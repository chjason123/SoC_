import cv2 as cv
import numpy as np
import matplotlib
from collections import deque

matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from skimage.filters import threshold_multiotsu
from collections import Counter

# 調整顯示視窗的副程式
# 輸入依序為視窗名稱、影像、縮放大小
# 無輸出，僅呼叫此函數協助顯示視窗
def show_scaled(win_name, image, scale):
    resized = cv.resize(image, None, fx=scale, fy=scale, interpolation=cv.INTER_AREA)
    cv.imshow(win_name, resized)

# 計算隸屬度的副程式
# 輸入依序為影像陣列、隸屬度三角形的三個頂點
# 輸出為一個計算完隸屬度的影像陣列
# 隸屬度通常為 0~1
def triangular_mf_array(X, a, b, c, ):
    """
    Vectorized 三角形 Membership Function
    X: 影像的灰階陣列 (rows x cols)
    a, b, c: 三角形三個關鍵點 (a < b < c)
    在 x=b 時隸屬度 = 1
    在 [a, b] 及 [b, c] 區段做線性上升/下降
    """
    # 先建立一個全 0 的浮點型陣列，大小和 X 相同
    out = np.zeros_like(X, dtype=float)

    # 設置一個較小的值
    # epsilon = 1e-6

    # 區域1: a < x < b，線性上升
    mask1 = (X >= a) & (X < b)
    out[mask1] = (X[mask1] - a) / (b - a)

    # 區域2: b <= x < c，線性下降
    mask2 = (X >= b) & (X <= c)
    out[mask2] = (c - X[mask2]) / (c - b)

    return out


# Harris 偵測角點的副程式
# 輸入為灰階影像
# 輸出為從灰階影像找到的角點
def detect_corners(gray):
    # Harris 參數
    block_size, ksize, k = 2, 3, 0.03

    dst = cv.cornerHarris(np.float32(gray), block_size, ksize, k)
    dst = cv.dilate(dst, None)
    th = 0.03 * dst.max()
    pts = np.argwhere(dst > th)
    corners = np.array([[x, y] for y, x in pts], dtype=np.float32).reshape(-1, 1, 2)
    return corners


def main():
    # 影片路徑、及讀取
    video_path = r"C:\Users\USER\Desktop\SoC_python\shrimp video\Shrimp2.mp4"
    cap = cv.VideoCapture(video_path)
    ret, old_frame = cap.read()
    if not cap.isOpened():
        print("無法開啟影片！")
        return
    # 放在 old_gray, corner_pts, maskOp 初始化之後，while True 之前
    flow_masks = deque(maxlen=50)
    # 統一將影像調整的大小，1280X720
    target_width = 1280
    target_height = 720
    # 調整影像大小及複製第一偵，給光流前後偵比對使用
    old_frame = cv.resize(old_frame, (target_width, target_height))
    old_gray = cv.cvtColor(old_frame, cv.COLOR_BGR2GRAY)

    # 變數宣告
    # 1.計數每偵的 Cnt
    # 2. 處理第一偵的變數(1 需處理 0 已處理第一偵)
    # 3.影像陣列(為了存每一偵，並200偵取影像中位數)
    # 4. 判斷是否有背景模型用
    # 5. 使用otsu切割幾階的變數
    # 6. 索引值，(在眾數處理中，找到出現數量最多的區間)
    # 7. 暫停旗號，在光流處理過程判斷是否成功追蹤角點

    frame_count = 0
    first_frame_process = 1
    gray_frames = []
    background_model = None
    num_classes = 4
    max_i = 0
    referenceCount = 0
    preaverageActivity = 0
    pausecount = 1
    activity_buffer = []

    # 存放每幀的蝦苗數量
    all_frame_modes = []
    # 1.累計每 50 幀蝦苗數量取眾數的陣列
    # 2.累計每幀蝦苗數量的陣列，用於繪圖展示
    filtered_counts = []
    eachFrameCnt = []


    # 變數宣告
    # 1.繪製每個membership function的線
    # 2.計算出的三角形高點
    # 3.兩三角形高點差值陣列，用於判斷是否太接近，太接近可以合併
    # 4.儲存活動力的陣列，長度限制50，表示只存50偵
    # 5.存每一階加權隸屬度平均跟算術平均的差值陣列，用於要決定把哪一階當作分割區的影像
    # 6.與上一個變數功能一致，此針對背景影像處理用，前一個針對灰階影像分割用
    line_objs = []
    maxFP_obj = []
    maxFePixDiffArr = []
    averageActivityArray = []
    twoAvDiff = []
    twoAvDiffBg = []

    # 變數宣告
    # 計數蝦苗數量
    # 1.計數蝦苗數量
    # 2.判斷 1、2階有沒有合併用，一個為協助運行合併後正確計算隸屬度使用的變數

    count_shrimps = 0
    combine12 = 0

    # 繪圖視窗的名稱宣告、長寬設定

    plt.ion()
    fig_area, ax_area = plt.subplots(figsize=(8, 6))
    ax_area.set_title("Distribution of Contour Areas")
    ax_area.set_xlabel("Contour Area")
    ax_area.set_ylabel("Frequency")
    ax_area.grid(True)

    cv.namedWindow("Original", cv.WINDOW_NORMAL)
    cv.namedWindow("gray", cv.WINDOW_NORMAL)
    cv.namedWindow("Background Model", cv.WINDOW_NORMAL)
    # cv.namedWindow("Weighted Avg M1", cv.WINDOW_NORMAL)
    # cv.namedWindow("2nd stage pixel", cv.WINDOW_NORMAL)
    # cv.namedWindow("Weighted Avg M3", cv.WINDOW_NORMAL)
    # cv.namedWindow("Weighted Avg M4", cv.WINDOW_NORMAL)
    # cv.namedWindow("arithmetic_avg Avg", cv.WINDOW_NORMAL)
    cv.namedWindow("Segmented Image", cv.WINDOW_NORMAL)
    # cv.namedWindow("BG Weighted Avg M1", cv.WINDOW_NORMAL)
    # cv.namedWindow("Bg 2nd stage pixel", cv.WINDOW_NORMAL)
    # cv.namedWindow("BG Weighted Avg M3", cv.WINDOW_NORMAL)
    # cv.namedWindow("BG Weighted Avg M4", cv.WINDOW_NORMAL)
    cv.namedWindow("BG Segmented Image", cv.WINDOW_NORMAL)
    cv.namedWindow("seg_diff_bin", cv.WINDOW_NORMAL)
    cv.namedWindow("Shrimp Detection", cv.WINDOW_NORMAL)
    cv.namedWindow("Masked Image", cv.WINDOW_NORMAL)
    cv.namedWindow("Mask", cv.WINDOW_NORMAL)
    cv.namedWindow("Contours", cv.WINDOW_NORMAL)
    cv.namedWindow("Harris + Lucas-Kanade", cv.WINDOW_NORMAL)

    # 設定縮放比例
    scale = 1

    # 使用3x3 kernel進行卷積計算加權平均
    kernel = np.ones((3, 3), dtype=float)
    # 算術平均kernel
    kernelAriAvg = np.ones((3, 3), dtype=float) / 9

    height, width = old_frame.shape[:2]
    fps = cap.get(cv.CAP_PROP_FPS) or 20.0

    videoscale = 0.5
    new_w, new_h = int(width * videoscale), int(height * videoscale)
    out = cv.VideoWriter(
        'demo_combined.avi',
        cv.VideoWriter_fourcc(*'XVID'),
        fps, (new_w * 2, new_h), True
    )

    # -----------------------------
    # 參數設定
    # -----------------------------
    # 批次計算 100 幀平均活動力
    batch_sum = 0.0
    batch_count = 0
    last_avg = None

    # 每 20 幀重新偵測角點
    RETRACK_INTERVAL = 20

    # Lucas-Kanade 參數
    lk_params = dict(
        winSize=(15, 15),
        maxLevel=2,
        criteria=(cv.TERM_CRITERIA_EPS | cv.TERM_CRITERIA_COUNT, 10, 0.03)
    )
    corner_pts = detect_corners(old_gray)
    color = np.random.randint(0, 255, (len(corner_pts), 3))
    maskOp = np.zeros_like(old_frame)

    while True:
        ret, frame = cap.read()

        if not ret:
            # print(f"該影片累積的蝦苗數量: {all_frame_modes}")
            # 找出所有幀數蝦苗數量的眾數
            final_hist, final_bin_edges = np.histogram(filtered_counts, bins=100)
            # 找到最多物件的區間索引
            final_max_bin_index = np.argmax(final_hist)

            final_lower_bound = final_bin_edges[final_max_bin_index]
            final_upper_bound = final_bin_edges[final_max_bin_index + 1]
            selected_counts = [val for val in filtered_counts if final_lower_bound <= val <= final_upper_bound]
            # 再從這些數值中找眾數
            shrimp_quantity = Counter(selected_counts).most_common(1)[0][0]
            if referenceCount // shrimp_quantity >= 2:
                shrimp_quantity = referenceCount
            print(f"該影片的蝦苗數量: {int(shrimp_quantity)}")
            if len(averageActivityArray) == 0:
                print("該影片的平均活動力低")
            else:
                finalAverageActivity = np.median(averageActivityArray)
                print(f"該影片的平均活動力: {finalAverageActivity}")

            # 提取出每固定偵取數量眾數的偵數
            frames = list(range(len(filtered_counts)))
            # 對應每偵的数量
            counts = filtered_counts
            # 提取出儲存的每一個平均活動力
            frames_activity = list(range(len(averageActivityArray)))
            counts_activity = averageActivityArray
            # 提取出每固定偵取數量眾數的偵數
            eachFrame = list(range(len(eachFrameCnt)))
            # 對應每偵的数量
            eachFrameQuantity = eachFrameCnt

            plt.ion()
            # 建視窗窗
            fig, ax = plt.subplots(figsize=(10, 6))
            fig_activity, ax_activity = plt.subplots(figsize=(10, 6))
            fig_eachFramQuantity, ax_eachFramQuantity = plt.subplots(figsize=(10, 6))

            # 設定標題與軸標籤
            ax.set_title("Shrimp Count per Frame")
            ax.set_xlabel("Frame Index")
            ax.set_ylabel("Shrimp Count")
            ax.grid(True)
            # 設定標題與軸標籤
            ax_activity.set_title("Activity Level per Frame")
            ax_activity.set_xlabel("Frame Index")
            ax_activity.set_ylabel("Activity Level")
            ax_activity.grid(True)

            # 設定標題與軸標籤
            ax_eachFramQuantity.set_title("Shrimp per Frame")
            ax_eachFramQuantity.set_xlabel("Each Frame")
            ax_eachFramQuantity.set_ylabel("Quantity")
            ax_eachFramQuantity.grid(True)

            # 畫圖
            ax.plot(frames, counts, marker='o', linestyle='-')
            ax_activity.plot(frames_activity, counts_activity, marker='o', linestyle='-')
            ax_eachFramQuantity.plot(eachFrame, eachFrameQuantity, marker='o', linestyle='-')
            plt.tight_layout()

            # final_filtered_count = np.median(filtered_counts)  # 對所有的結果進行最終的中位數濾波
            # print(f"影像播放結束後累計的中位數蝦苗數量: {final_filtered_count}")
            if len(averageActivityArray) > 0:
                hist, bins = np.histogram(averageActivityArray, bins=100)
                max_bin_index = np.argmax(hist)
                lower = bins[max_bin_index]
                upper = bins[max_bin_index + 1]
                selected = [val for val in averageActivityArray if lower <= val <= upper]
                mode_activity = Counter(selected).most_common(1)[0][0]

                print(f"整部影片的活動力眾數（平滑50幀後取眾數）: {mode_activity:.2f}")
            else:
                print("無法計算活動力眾數，資料不足")

            break
        # 將每偵讀取的影片格式調整並顯示
        frame = cv.resize(frame, (target_width, target_height))
        show_scaled("Original", frame, scale)
        gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
        show_scaled("gray", gray, scale)

        # 將灰階影像做高斯濾波，並放進影像陣列

        gray_filtered = cv.medianBlur(gray, 5)
        gray_frames.append(gray_filtered)

        # 第一偵處理部分
        # 用於建立模糊三角形及合併處理(合併條件:是否有兩個三角形頂點接近)

        if first_frame_process != 0:
            # 計算第一幀的直方圖
            hist_first = cv.calcHist([gray], [0], None, [256], [0, 256]).ravel()
            # Otsu找閥值
            try:
                thresholds = threshold_multiotsu(gray, classes=num_classes)
                print("使用otsu在灰階影像histogram找到的閥值:", thresholds)
            except ValueError:
                print("灰階影像 Otsu 閾值計算失敗，跳過此幀")
                thresholds = np.array([])

            # 建立 Matplotlib 視窗 ，繪製模糊三角形及像素頻率直方圖用
            # 包含圖表長寬設定、名稱、數值的範圍
            plt.ion()
            # ax1: 左邊 Y 軸 (Membership)
            fig, ax1 = plt.subplots(figsize=(8, 6))
            # ax2: 右邊 Y 軸 (直方圖)
            ax2 = ax1.twinx()

            ax1.set_xlim(0, 255)
            ax1.set_ylim(0, 1.05)
            ax1.set_xlabel('Gray Value')
            ax1.set_ylabel('Membership (0~1)')

            x_vals = np.arange(256)

            # 初始化直方圖(給一個全 0 的 hist，後面迴圈中會動態更新高度)
            # 以及直方圖 bar的設置
            init_hist = np.zeros(256, dtype=np.float32)
            bars = ax2.bar(x_vals, init_hist, width=1.0, color='lightgray', alpha=0.7, label='Histogram')
            ax2.set_ylabel('Counts')


            #合併模糊三角圖、像素頻率直方圖至同一個視窗
            lines_1, labels_1 = ax1.get_legend_handles_labels()
            lines_2, labels_2 = ax2.get_legend_handles_labels()
            ax1.legend(lines_1 + lines_2, labels_1 + labels_2, loc='upper right')

            colors = ['r-', 'g-', 'b-', 'm-', 'y-']

            # 處理合併部分
            # 包含提取每一個三角形的頂點做相減、判斷是否需合併、以及需合併時做的處理
            # 以下取出未合併時模糊三角形高點(兩低點中間像素出現次數最高的像素值)
            for i in range(len(thresholds) + 1):
                if i == 0:
                    pixel_range = np.arange(i, thresholds[i])
                    hist_range = hist_first[i: thresholds[i]]
                    max_freq_pixel = pixel_range[np.argmax(hist_range)]
                elif i == len(thresholds):
                    pixel_range = np.arange(thresholds[i - 1], 255)
                    hist_range = hist_first[thresholds[i - 1]: 255]
                    max_freq_pixel = pixel_range[np.argmax(hist_range)]
                else:
                    pixel_range = np.arange(thresholds[i - 1], thresholds[i])
                    hist_range = hist_first[thresholds[i - 1]: thresholds[i]]
                    max_freq_pixel = pixel_range[np.argmax(hist_range)]
                # 計算兩兩三形形高點差值
                if i > 0:
                    maxFePixDiff = abs(max_freq_pixel - maxFP_obj[i - 1])
                    maxFePixDiffArr.append(maxFePixDiff)
                maxFP_obj.append(max_freq_pixel)
                # 列印高點的值跟差值陣列
            print(f"maxFP: {maxFP_obj}")
            print(f"maxFePixDiff: {maxFePixDiffArr}")

            # 判斷是否需併三角形
            if any(x < 15 for x in maxFePixDiffArr):
                # 清空第一次尋找三角形高點的內容
                maxFP_obj.clear()
                # 迴圈次數減一(少跑一階)
                looptimes = len(thresholds)
                print(f"looptimes: {looptimes}")
                # 找出最小值的索引
                min_valueInd = np.argmin(maxFePixDiffArr)
                print(f"min_valueInMaxFePixDiff: {min_valueInd}")

                # 重新找合併後所有三角形的高點
                for i in range(looptimes):
                    if i == 0:
                        if i == min_valueInd:
                            pixel_range = np.arange(i, thresholds[i + 1])
                            hist_range = hist_first[i: thresholds[i + 1]]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                            combine12 = 1
                        else:
                            pixel_range = np.arange(i, thresholds[i])
                            hist_range = hist_first[i: thresholds[i]]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                    elif i == looptimes - 1:
                        if i == min_valueInd:
                            pixel_range = np.arange(thresholds[i - 1], 255)
                            hist_range = hist_first[thresholds[i - 1]: 255]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                        else:
                            pixel_range = np.arange(thresholds[i], 255)
                            hist_range = hist_first[thresholds[i]: 255]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                    else:
                        if i == min_valueInd:
                            pixel_range = np.arange(thresholds[i - 1], thresholds[i + 1])
                            hist_range = hist_first[thresholds[i - 1]: thresholds[i + 1]]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                        elif combine12 == 1:
                            pixel_range = np.arange(thresholds[i], thresholds[i + 1])
                            hist_range = hist_first[thresholds[i]: thresholds[i + 1]]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                        else:
                            pixel_range = np.arange(thresholds[i - 1], thresholds[i])
                            hist_range = hist_first[thresholds[i - 1]: thresholds[i]]
                            max_freq_pixel = pixel_range[np.argmax(hist_range)]
                    maxFP_obj.append(max_freq_pixel)
                    print(f"i: {i}")
            else:
                looptimes = len(thresholds) + 1
            print(f"maxFPCom: {maxFP_obj}")
            PixelAllocate = 255 // (looptimes - 1)
            print(f"PixelAllocate: {PixelAllocate}")

            # 計算membership function並根據其結果建立每一階三角形的線條
            for i in range(looptimes):
                if i == 0:
                    if i == min_valueInd:
                        membShipFunc = triangular_mf_array(x_vals, 0, maxFP_obj[i], thresholds[i + 1])
                    else:
                        membShipFunc = triangular_mf_array(x_vals, 0, maxFP_obj[i], thresholds[i])
                    print(f"在0~th{i +~1}之间出现频率最高的像素值是: {maxFP_obj[i]}")
                elif i == len(thresholds) - 1:
                    if i == min_valueInd:
                        membShipFunc = triangular_mf_array(x_vals, thresholds[i - 1], maxFP_obj[i], 255)
                    else:
                        membShipFunc = triangular_mf_array(x_vals, thresholds[i], maxFP_obj[i], 255)
                    print(f"在th{i}~255之间出现频率最高的像素值是: {maxFP_obj[i]}")
                else:
                    if i == min_valueInd:
                        membShipFunc = triangular_mf_array(x_vals, thresholds[i - 1], maxFP_obj[i], thresholds[i + 1])
                    elif combine12 == 1:
                        membShipFunc = triangular_mf_array(x_vals, thresholds[i], maxFP_obj[i], thresholds[i + 1])
                    else:
                        membShipFunc = triangular_mf_array(x_vals, thresholds[i - 1], maxFP_obj[i], thresholds[i])
                    print(f"在th{i}~th{i + 1}之间出现频率最高的像素值是: {maxFP_obj[i]}")
                line, = ax1.plot(x_vals, membShipFunc, colors[i], label=f'M{i + 1}')
                line_objs.append(line)

            maxFePixDiffArr.clear()
            first_frame_process = 0

        # 每 200 張影格更新一次背景
        if frame_count % 200 == 0:
            gray_array = np.array(gray_frames)
            background_model = np.median(gray_array, axis=0).astype(np.uint8)
            gray_frames.clear()

        # 計算灰階直方圖 (1D, 256 bins)
        hist = cv.calcHist([gray], [0], None, [256], [0, 256]).ravel()

        # 更新 bar 高度
        for rect, h in zip(bars, hist):
            rect.set_height(h)

        # 調整右邊 Y 軸最大值 (讓最高 bar 不會被截斷)
        hist_max = max(hist)
        ax2.set_ylim(0, hist_max * 1.1 if hist_max > 0 else 1)

        #  重新繪製
        plt.draw()
        # 短暫停頓，讓畫面刷新
        plt.pause(0.1)

        # 計算算術平均
        arithmetic_avg = cv.filter2D(gray, -1, kernelAriAvg)
        # 顯示算術平均的結果
        # show_scaled("arithmetic_avg Avg", arithmetic_avg, scale)
        if background_model is not None:
            arithmetic_avg_Bg = cv.filter2D(background_model, -1, kernelAriAvg)
        # 影像分割部分
        # 1.計算灰階影像、背景模型Membership
        # 2.計算階階加權平均
        # 3.分割灰階影像、背景模型
        for i in range(looptimes):
            # 如果有背景模型
            if background_model is not None:
                if i == 0:
                    if i == min_valueInd:
                        caculateBgMF = triangular_mf_array(background_model, 0, maxFP_obj[i], thresholds[i + 1])
                    else:
                        caculateBgMF = triangular_mf_array(background_model, 0, maxFP_obj[i], thresholds[i])
                elif i == len(thresholds) - 1:
                    if i == min_valueInd:
                        caculateBgMF = triangular_mf_array(background_model, thresholds[i - 1], maxFP_obj[i], 255)
                    else:
                        caculateBgMF = triangular_mf_array(background_model, thresholds[i], maxFP_obj[i], 255)
                else:
                    if i == min_valueInd:
                        caculateBgMF = triangular_mf_array(background_model, thresholds[i - 1], maxFP_obj[i],
                                                           thresholds[i + 1])
                    elif combine12 == 1:
                        caculateBgMF = triangular_mf_array(background_model, thresholds[i], maxFP_obj[i],
                                                           thresholds[i + 1])
                    else:
                        caculateBgMF = triangular_mf_array(background_model, thresholds[i - 1], maxFP_obj[i],
                                                           thresholds[i])

                weighted_sum_Bg = cv.filter2D(caculateBgMF * background_model, -1, kernel)
                total_membership_Bg = cv.filter2D(caculateBgMF, -1, kernel)
                total_membership_Bg = np.where(total_membership_Bg == 0, 1, total_membership_Bg)
                weighted_avg_Bg = weighted_sum_Bg / total_membership_Bg

                diffBg = np.abs(weighted_avg_Bg - arithmetic_avg_Bg)
                twoAvDiffBg.append(diffBg)
            # 無背景模型
            if i == 0:
                if i == min_valueInd:
                    caculateMF = triangular_mf_array(gray, 0, maxFP_obj[i], thresholds[i + 1])
                else:
                    caculateMF = triangular_mf_array(gray, 0, maxFP_obj[i], thresholds[i])
            elif i == len(thresholds) - 1:
                if i == min_valueInd:
                    caculateMF = triangular_mf_array(gray, thresholds[i - 1], maxFP_obj[i], 255)
                else:
                    caculateMF = triangular_mf_array(gray, thresholds[i], maxFP_obj[i], 255)
            else:
                if i == min_valueInd:
                    caculateMF = triangular_mf_array(gray, thresholds[i - 1], maxFP_obj[i], thresholds[i + 1])
                elif combine12 == 1:
                    caculateMF = triangular_mf_array(gray, thresholds[i], maxFP_obj[i], thresholds[i + 1])
                else:
                    caculateMF = triangular_mf_array(gray, thresholds[i - 1], maxFP_obj[i], thresholds[i])

            # 計算每個隸屬度對應的加權總和
            weighted_sum = cv.filter2D(caculateMF * gray, -1, kernel)
            # 計算隸屬度總和
            total_membership = cv.filter2D(caculateMF, -1, kernel)
            # 確保除數不為零
            total_membership = np.where(total_membership == 0, 1, total_membership)
            # 計算加權平均
            weighted_avg = weighted_sum / total_membership
            # 顯示灰階影像、背景不同隸屬度上的像素
            # show_scaled(f"Weighted Avg M{i+1}", weighted_avg, scale)
            # 比較加權平均與算術平均的差距
            diff = np.abs(weighted_avg - arithmetic_avg)
            twoAvDiff.append(diff)

        # 以下選擇最接近算術平均的隸屬度階數並分配該階影像
        # 灰階影像部分
        min_index = np.argmin(twoAvDiff, axis=0)
        # print(f"min_index: {min_index}")
        segmented_result = np.full_like(gray, min_index * 127, dtype=np.uint8)
        show_scaled("Segmented Image", segmented_result, scale)
        # 背景模型
        min_indexBg = np.argmin(twoAvDiffBg, axis=0)
        Bg_segmented_result = np.full_like(background_model, min_indexBg * 127, dtype=np.uint8)
        show_scaled("BG Segmented Image", Bg_segmented_result, scale)

        # 存在背景模型需做的處理部分
        if background_model is not None:
            show_scaled("Background Model", background_model, scale)

            # 建立容器的遮罩，用於鎖定微小生物區域
            if frame_count == 0:
                print(f"frame_count: {frame_count}")
                x, y = 720, 360
                pixel_val = int(Bg_segmented_result[y, x])
                print(f"Frame {frame_count}: Bg_segmented_result[{x},{y}] = {pixel_val}")

                # 提取 Bg_segmented_result 中所有等于 pixel_val 的像素
                tgMaskPixel = cv.inRange(Bg_segmented_result, pixel_val, pixel_val)
                # 二值化處理，將影像中的白色區域轉換為 255，其他區域為 0
                # _, thresh = cv.threshold(Bg_segmented_result, coordinates, 0, cv.THRESH_BINARY)

                # 找到所有輪廓
                contours, _ = cv.findContours(tgMaskPixel, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)

                # 找到最大面積的輪廓
                max_contour = max(contours, key=cv.contourArea)

                # 建立一個新的空白黑色 mask
                mask = np.zeros_like(Bg_segmented_result)

                # 在 mask 上繪製最大輪廓
                cv.drawContours(mask, [max_contour], -1, (255), thickness=cv.FILLED)
                show_scaled("Mask", mask, scale)

            # 灰階分割影像與背景分割影像相減
            seg_diff = cv.absdiff(segmented_result, Bg_segmented_result)

            # 對相減後影像二值化
            _, seg_diff_bin = cv.threshold(seg_diff, 0, 255, cv.THRESH_BINARY)
            show_scaled("seg_diff_bin", seg_diff_bin, scale)
            segDiffBinRgb = cv.cvtColor(seg_diff_bin, cv.COLOR_GRAY2BGR)

            # 提取圓內的像素
            # mask = np.zeros(seg_diff_bin.shape[:2], dtype="uint8")
            # cv.circle(mask, center, radius, 255, -1)  # 用白色填充圓形區域
            masked_image = cv.bitwise_and(seg_diff_bin, seg_diff_bin, mask=mask)

            # 顯示原始影像與處理後的影像
            show_scaled("Masked Image", masked_image, scale)

            # 輪廓偵測
            contours, hierarchy = cv.findContours(masked_image, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)

            # 畫輪廓
            colored_masked_image = cv.cvtColor(masked_image, cv.COLOR_GRAY2BGR)
            contoursIm = np.zeros_like(colored_masked_image)
            cv.drawContours(contoursIm, contours, -1, (0, 255, 0), 2)

            # 顯示帶輪廓的影像
            show_scaled("Contours", contoursIm, scale)

            # 計算所有輪廓的面積，並將輪廓與面積一起保存在一個列表中
            contour_area_pairs = [(cnt, cv.contourArea(cnt)) for cnt in contours if 1 < cv.contourArea(cnt) < 50]
            # 計算篩選後的輪廓數量
            num_filtered_contours = len(contour_area_pairs)

            # 顯示篩選後的輪廓數量
            print(f"輪廓數量: {num_filtered_contours}")

            # 如果存在有效的輪廓面積
            if contour_area_pairs:
                # 提取面積
                areas = np.array([area for _, area in contour_area_pairs])
                min_ai, max_ai = areas.min(), areas.max()

                # 為繪製輪廓面積出現頻率的直方圖做設定
                ax_area.clear()
                ax_area.set_title("Distribution of Contour Areas")
                ax_area.set_xlabel("Contour Area")
                ax_area.set_ylabel("Frequency")
                ax_area.grid(True)

                # 抓出所有輪廓面積值的範圍
                bin_edges = np.arange(min_ai, max_ai)


                # 繪製輪廓面積值出現頻率的直方圖
                count, bin, patches = ax_area.hist(
                    areas,
                    bins=bin_edges,
                    edgecolor='black',
                    alpha=0.7
                )


                print("Contour Area Distribution:")
                # 找出眾數面積的部分
                for i, freq in enumerate(count):
                    # 把每個區間邊界取出來以便顯示
                    left = bin_edges[i]
                    right = bin_edges[i + 1]
                    # print(f"  Area in [{int(left)}, {int(right)}):  Frequency = {int(freq)}")

                if count is not None and len(count) > 0:
                    # 找到出现频率最高的那個面積的所在區間
                    max_i = np.argmax(count)
                    premax_i = max_i
                    print(f"max_i: {max_i}, ")
                    lower_bound = bin[max_i]
                    preLower = lower_bound
                    upper_bound = bin[max_i + 1]
                    preUpper = upper_bound
                    print(f"lower_bound: {lower_bound}, upper_bound: {upper_bound} , Mode Area: {max_i}")
                # 如果 count 為空，表示有異常狀況發生導致抓不到輪廓面積值，維持之前找到的區間
                else:
                    max_i = premax_i
                    lower_bound = preLower
                    upper_bound = preUpper
                # 調整每個 X軸的值，使其都為整數(方便觀察用)
                ax_area.set_xticks(np.arange(min_ai, max_ai + 1, 1))

                # 固定坐標軸的範圍使其不要隨出現頻率跳動
                ax_area.set_xlim(min_ai - 0.5, max_ai + 0.5)
                # 檢查 count 是否為空數組
                if count.size > 0:
                    ax_area.set_ylim(0, count.max() * 1.1)
                # 如果 count 為空，保持上一個 Y 軸範圍
                else:
                    ax_area.set_ylim(0, ax_area.get_ylim()[1])

                    # 8. 刷新
                fig_area.canvas.draw()
                plt.pause(0.01)

                # 選出集中區域的面積值
                selected_areas = [area for area in areas if lower_bound <= area <= upper_bound]
                # print(f"selected_areas: {selected_areas}")

                # 如果 selected_areas 不為空
                if selected_areas:
                    area_counts = Counter(selected_areas)
                    mode_area, _ = area_counts.most_common(1)[0]

                    if len(contour_area_pairs) < 200:
                        mode_area = mode_area * 5
                    # elif len(contour_area_pairs) > 1500 and count_shrimps > 7000  :
                    # mode_area = mode_area * 2
                    else:
                        mode_area = mode_area
                else:
                    # 把面積眾數設為1 處理沒有偵測到輪廓的情況
                    selected_areas = [1]
                    mode_area = 1
                # 計數部分處理
                count_shrimps = 0
                for cnt, area in contour_area_pairs:
                    x, y, w, h = cv.boundingRect(cnt)
                    # 面積大於眾數，用大面積除以眾數
                    if area > mode_area:
                        count_shrimps = count_shrimps + (area / mode_area)

                        # 畫紅框
                    cv.rectangle(segDiffBinRgb, (x, y), (x + w, y + h), (0, 0, 255), 2)
                # if firstcount == 1:
                # caculateCorrectRange = abs((len(contour_area_pairs) * 2) - count_shrimps)
                # if caculateCorrectRange > 1000:
                # correctRange = 0
                # else:
                # correctRange = 1
                # firstcount = 0
            else:
                mode_area = 0

            # 顯示當前幀的計數
            cv.putText(segDiffBinRgb, f"Shrimp Count: {count_shrimps}", (20, 50), cv.FONT_HERSHEY_SIMPLEX,
                       1, (0, 0, 255), 2, cv.LINE_AA)
            cv.putText(segDiffBinRgb, f"Mode Area: {mode_area}", (20, 80), cv.FONT_HERSHEY_SIMPLEX,
                       1, (0, 0, 255), 2, cv.LINE_AA)
            show_scaled("Shrimp Detection", segDiffBinRgb, scale)
        #累計每一偵的蝦苗數量以便後續顯示用
        eachFrameCnt.append(count_shrimps)

        # 數量眾數的處理
        # 每 50 幀對蝦苗數量進行眾數
        if frame_count % 50 == 0 and frame_count > 0:
            print(f"frame_count: {frame_count}")
            fiftyCountModeHist, bin_edges = np.histogram(all_frame_modes, bins=100)
            # 找到最多物件的區間索引
            maxAreaIndex = np.argmax(fiftyCountModeHist)

            lower_bound = bin_edges[maxAreaIndex]
            upper_bound = bin_edges[maxAreaIndex + 1]
            selectedCountPerFifty = [val for val in all_frame_modes if lower_bound <= val <= upper_bound]
            # 再從這些數值中找眾數
            print(f"selectedCountPerFifty: {selectedCountPerFifty}")
            if selectedCountPerFifty:
                modeShrimpQuantity = Counter(selectedCountPerFifty).most_common(1)[0][0]
                preModeShrimp = modeShrimpQuantity
            else:
                modeShrimpQuantity = preModeShrimp

            print(f"每50偵找出數眾眾數數: {int(modeShrimpQuantity)}")

            if modeShrimpQuantity > 10:
                filtered_counts.append(modeShrimpQuantity)

            if frame_count == 100:
                referenceCount = modeShrimpQuantity

            all_frame_modes.clear()

        print(f"該影片蝦苗數量參考數: {int(referenceCount)}")
        # 異常狀況導致數到數量偏差太大時，不納入計算
        if frame_count > 100:
            countDecreaseReference = abs(count_shrimps - referenceCount)
            if countDecreaseReference > 1000:
                count_shrimps = 0
        # 累計50偵的蝦苗數量，供數量眾數處理部分使用
        if count_shrimps > 0:
            all_frame_modes.append(count_shrimps)

        # 光流處理部分
        # —— 计算光流并只保留最近 50 帧轨迹 ——
        p1, st, err = cv.calcOpticalFlowPyrLK(
            old_gray, gray, corner_pts, None, **lk_params
        )
        if p1 is None or len(p1) == 0:
            # 追踪失败，保存 old_gray, 计数器加一，跳下一帧
            old_gray = gray.copy()
            frame_count += 1
            continue

        # 筛出成功追踪的点
        good_new = p1[st == 1]
        good_old = corner_pts[st == 1]
        # 1) 計算每個點位移的歐式距離（光流位移）
        disp = np.linalg.norm(good_new - good_old, axis=1)
        # 加總全部位移，定義為本幀的「活動力」(當前畫面移動距離)
        activity_level = disp.sum()

        activity_buffer.append(activity_level)

        # 每 50 幀取平均活動力 → 存入 averageActivityArray
        if frame_count % 50 == 0 and frame_count > 0:
            batch_avg_activity = np.mean(activity_buffer)
            averageActivityArray.append(round(batch_avg_activity, 2))
            activity_buffer.clear()

        # 2) 初始化這一幀的光流遮罩 frame_mask，與原圖同大小
        frame_mask = np.zeros_like(frame)
        for i, (n, o) in enumerate(zip(good_new, good_old)):
            x1, y1 = n.ravel().astype(int)  # 當前新位置
            x0, y0 = o.ravel().astype(int)  # 前一幀位置
            # 在新舊位置間畫一條線，表示光流方向與距離
            cv.line(frame_mask, (x1, y1), (x0, y0), color[i].tolist(), 2)

        # 3) 將這一幀的光流線結果 frame_mask 推入緩衝區（只保留最近 50 幀）
        flow_masks.append(frame_mask)

        # 4) 將過去 50 幀所有 frame_mask 疊加起來，成為總光流遮罩 maskOp
        maskOp = np.zeros_like(frame)
        for m in flow_masks:
            maskOp = cv.add(maskOp, m)

        # 5) 將光流遮罩加回原始畫面，並在每個新點位置畫圓圈（光流終點）
        tracked = cv.add(frame, maskOp)
        for i, n in enumerate(good_new):
            x1, y1 = n.ravel().astype(int)
            cv.circle(tracked, (x1, y1), 5, color[i].tolist(), -1)

        # 6) 將原始畫面與光流追蹤畫面縮小、左右拼接成一張圖 combined
        small1 = cv.resize(frame, (new_w, new_h))
        small2 = cv.resize(tracked, (new_w, new_h))
        combined = cv.hconcat([small1, small2])

        # 在左上角顯示活動力值
        cv.putText(combined, f"Activity: {activity_level:.2f}", (10, 30),
                   cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

        # 計算目前是第幾個批次、第幀（每 50 幀為一個單位）(取眾數用50幀，<50誤差高，>50增加運算)
        batch_idx = frame_count // 50 + 1
        frame_in_batch = frame_count % 50 + 1
        cv.putText(combined,
                   f"Batch {batch_idx}, Frame {frame_in_batch}/50",
                   (10, 70), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 255), 2)

        # 顯示畫面並寫入影片
        cv.imshow("Harris + Lucas-Kanade", combined)
        out.write(combined)

        # 7) 更新資料供下一幀使用
        old_gray = gray.copy()  # 當前影格轉為舊影格
        corner_pts = good_new.reshape(-1, 1, 2)  # 更新追蹤點位置
        frame_count += 1  # 幀數 +1

        # 清除上一幀的活動差值比較用陣列
        twoAvDiff.clear()
        twoAvDiffBg.clear()

        # 若按下鍵盤 q → 離開迴圈
        if cv.waitKey(10) & 0xFF == ord('q'):
            break

        # 關閉 Matplotlib、影片與視窗
    plt.ioff()
    plt.show()
    cap.release()
    cv.destroyAllWindows()
    plt.close('all')


if __name__ == "__main__":
    main()