% 假设 P 是 77301x3 的数组，格式为 (index_x, index_y, depth)
index_x = round(P(:, 1));
index_y = round(P(:, 2));
depth = P(:, 3);

% 获取图像的尺寸
max_x = max(index_x);
max_y = max(index_y);
max_val = max(max_x, max_y);
max_x = max_val;
max_y = max_val;

% 创建深度图
depth_map = NaN(max_y, max_x); % 使用 NaN 初始化，以便后续处理

% 填充深度图
for i = 1:length(index_x)
    depth_map(index_y(i), index_x(i)) = depth(i);
end

% 将 NaN 值替换为最小深度值
min_depth = min(depth);
nan_index = isnan(depth_map);
depth_map(nan_index) = min_depth;

% 归一化深度图
depth_map_normalized = (depth_map - min(depth_map(:))) / (max(depth_map(:)) - min(depth_map(:)));
depth_map_normalized_inv = 1 - depth_map_normalized;
depth_map_normalized_inv(nan_index) = 0;
depth_map_normalized(nan_index) = 0;

% 自定义 jet 颜色映射，将 0 对应为黑色
custom_colormap = jet(256);
custom_colormap(1, :) = [0, 0, 0]; % 将第一个颜色（对应值为 0）设置为黑色

% 显示归一化后的深度图
figure;
imshow(depth_map_normalized, []);
title('Normalized RAW Depth Map');
colormap(custom_colormap); % 使用 jet 颜色映射
colorbar; % 显示颜色条