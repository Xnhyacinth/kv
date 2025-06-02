

import torch
import cupy as cp
import time

x_torch = torch.randint(0, 2, (1, 32, 512, 128), dtype=torch.bool, device='cuda')
st = time.time()
x_cupy = cp.asarray(x_torch)
x_packed = cp.packbits(x_cupy)
et = time.time()
# 可以选择保存 x_packed，或传输、缓存等
print("原始显存:", x_torch.nbytes / 1024, "KB")
print("原始显存:", x_cupy.nbytes / 1024, "KB")
print("压缩后显存:", x_packed.nbytes / 1024, "KB")

x_cupy = cp.unpackbits(x_packed)
x_torch = torch.as_tensor(x_cupy)
print("解压缩耗时:", et - st, "秒")
print("解压缩耗时:", time.time() - et, "秒")
print("恢复后显存:", x_torch.nbytes / 1024, "KB")
print("恢复后显存:", x_cupy.nbytes / 1024, "KB")