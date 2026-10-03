# Wavelet-Based Image Compression

MATLAB scripts exploring image compression through wavelet decomposition, written for a digital image processing course project (EEE4512).

## Overview

The idea behind wavelet compression is that most of an image's visual information lives in a relatively small number of large wavelet coefficients — the rest can be thresholded away with little effect on perceived quality. These scripts decompose a test image with the 2D discrete wavelet transform, zero out the smaller coefficients, and reconstruct the image to see how much can be thrown away before quality noticeably degrades.

## Files

- **`wavelet.m`** — Full pipeline: decomposes the image with `wavedec2` (Daubechies-4, 12 levels), thresholds coefficients to hit a target compression ratio, reconstructs the image, and reports compression ratio, bits per pixel, MSE, and PSNR.
- **`wavelet_comp.m`** — Compares reconstruction quality at several thresholds (keeping the top 10%, 5%, 1%, and 0.5% of coefficients) side by side.
- **`wavelet_decomposition.m`** — Visualizes a two-level Haar wavelet decomposition of an RGB image, showing the approximation and horizontal/vertical/diagonal detail subbands for each color channel.

## Requirements

MATLAB with the Wavelet Toolbox and Image Processing Toolbox (`wavedec2`, `waverec2`, `dwt2`, `imread`, `immse`, etc.). The scripts use `autumn.tif`, one of MATLAB's built-in sample images, so no external dataset is needed.

## Usage

Open any of the `.m` files in MATLAB and run. `wavelet.m` and `wavelet_comp.m` display the original and reconstructed images side by side along with quality metrics; `wavelet_decomposition.m` plots the individual wavelet subbands.
