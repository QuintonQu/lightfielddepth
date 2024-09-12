% 假设 P 是 77301x3 的数组，格式为 (index_x, index_y, depth)
index_x = round(P(:, 1));
index_y = round(P(:, 2));
depth = P(:, 3);

% 创建一个新的数组，将 index_x 和 index_y 组合在一起
coordinates = [index_x, index_y];

% 使用 unique 函数找到唯一的 (x, y) 坐标
[unique_coords, ~, idx] = unique(coordinates, 'rows');

% 检查是否有重复的 (x, y) 坐标
if size(unique_coords, 1) < size(coordinates, 1)
    disp('存在相同的 (x, y) 坐标:');
    % 找到重复的坐标
    [counts, unique_idx] = hist(idx, unique(idx));
    duplicate_coords = unique_coords(counts > 1, :);
    disp(duplicate_coords);
else
    disp('没有相同的 (x, y) 坐标');
end