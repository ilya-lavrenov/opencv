/*M///////////////////////////////////////////////////////////////////////////////////////
//
//  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
//
//  By downloading, copying, installing or using the software you agree to this license.
//  If you do not agree to this license, do not download, install,
//  copy or use the software.
//
//
//                           License Agreement
//                For Open Source Computer Vision Library
//
// Copyright (C) 2000-2008, Intel Corporation, all rights reserved.
// Copyright (C) 2009, Willow Garage Inc., all rights reserved.
// Third party copyrights are property of their respective owners.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
//   * Redistribution's of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//   * Redistribution's in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//   * The name of the copyright holders may not be used to endorse or promote products
//     derived from this software without specific prior written permission.
//
// This software is provided by the copyright holders and contributors "as is" and
// any express or implied warranties, including, but not limited to, the implied
// warranties of merchantability and fitness for a particular purpose are disclaimed.
// In no event shall the Intel Corporation or contributors be liable for any direct,
// indirect, incidental, special, exemplary, or consequential damages
// (including, but not limited to, procurement of substitute goods or services;
// loss of use, data, or profits; or business interruption) however caused
// and on any theory of liability, whether in contract, strict liability,
// or tort (including negligence or otherwise) arising in any way out of
// the use of this software, even if advised of the possibility of such damage.
//
//M*/

////////////////////////////////////////////////////////////////////////////////
//
// NVIDIA CUDA implementation of Viola-Jones Object Detection Framework
//
// The algorithm and code are explained in the upcoming GPU Computing Gems
// chapter in detail:
//
//   Anton Obukhov, "Haar Classifiers for Object Detection with CUDA"
//   PDF URL placeholder
//   email: aobukhov@nvidia.com, devsupport@nvidia.com
//
// Credits for help with the code to:
// Alexey Mendelenko, Cyril Crassin, and Mikhail Smirnov.
//
////////////////////////////////////////////////////////////////////////////////

#if !defined CUDA_DISABLER

#include <algorithm>
#include <cstdio>

#include "NCV.hpp"
#include "NCVAlg.hpp"
#include "NPP_staging/NPP_staging.hpp"
#include "NCVRuntimeTemplates.hpp"
#include "NCVHaarObjectDetection.hpp"
void applyHaarClassifierAnchorParallelDynTemplate(NcvBool tbInitMaskPositively,
                                                  NcvBool tbCacheTextureIImg,
                                                  NcvBool tbCacheTextureCascade,
                                                  NcvBool tbReadPixelIndexFromVector,
                                                  NcvBool tbDoAtomicCompaction,

                                                  dim3 gridConf, dim3 blockConf, cudaStream_t cuStream,

                                                  Ncv32u *d_IImg, Ncv32u IImgStride,
                                                  Ncv32f *d_weights, Ncv32u weightsStride,
                                                  HaarFeature64 *d_Features, HaarClassifierNode128 *d_ClassifierNodes, HaarStage64 *d_Stages,
                                                  Ncv32u *d_inMask, Ncv32u *d_outMask,
                                                  Ncv32u mask1Dlen, Ncv32u mask2Dstride,
                                                  NcvSize32u anchorsRoi, Ncv32u startStageInc,
                                                  Ncv32u endStageExc, Ncv32f scaleArea)
{
}


void applyHaarClassifierClassifierParallelDynTemplate(NcvBool tbCacheTextureIImg,
                                                      NcvBool tbCacheTextureCascade,
                                                      NcvBool tbDoAtomicCompaction,

                                                      dim3 gridConf, dim3 blockConf, cudaStream_t cuStream,

                                                      Ncv32u *d_IImg, Ncv32u IImgStride,
                                                      Ncv32f *d_weights, Ncv32u weightsStride,
                                                      HaarFeature64 *d_Features, HaarClassifierNode128 *d_ClassifierNodes, HaarStage64 *d_Stages,
                                                      Ncv32u *d_inMask, Ncv32u *d_outMask,
                                                      Ncv32u mask1Dlen, Ncv32u mask2Dstride,
                                                      NcvSize32u anchorsRoi, Ncv32u startStageInc,
                                                      Ncv32u endStageExc, Ncv32f scaleArea)
{
}

void initializeMaskVectorDynTemplate(NcvBool tbMaskByInmask,
                                     NcvBool tbDoAtomicCompaction,

                                     dim3 gridConf, dim3 blockConf, cudaStream_t cuStream,

                                     Ncv32u *d_inMask, Ncv32u *d_outMask,
                                     Ncv32u mask1Dlen, Ncv32u mask2Dstride,
                                     NcvSize32u anchorsRoi, Ncv32u step)
{
}


Ncv32u getStageNumWithNotLessThanNclassifiers(Ncv32u N, HaarClassifierCascadeDescriptor &haar,
                                              NCVVector<HaarStage64> &h_HaarStages)
{
    Ncv32u i = 0;
    for (; i<haar.NumStages; i++)
    {
        if (h_HaarStages.ptr()[i].getNumClassifierRootNodes() >= N)
        {
            break;
        }
    }
    return i;
}


NCVStatus ncvApplyHaarClassifierCascade_device(NCVMatrix<Ncv32u> &integral,
                                               NCVMatrix<Ncv32f> &d_weights,
                                               NCVMatrixAlloc<Ncv32u> &d_pixelMask,
                                               Ncv32u &numDetections,
                                               HaarClassifierCascadeDescriptor &haar,
                                               NCVVector<HaarStage64> &h_HaarStages,
                                               NCVVector<HaarStage64> &d_HaarStages,
                                               NCVVector<HaarClassifierNode128> &d_HaarNodes,
                                               NCVVector<HaarFeature64> &d_HaarFeatures,
                                               NcvBool bMaskElements,
                                               NcvSize32u anchorsRoi,
                                               Ncv32u pixelStep,
                                               Ncv32f scaleArea,
                                               INCVMemAllocator &gpuAllocator,
                                               INCVMemAllocator &cpuAllocator,
                                               cudaDeviceProp &devProp,
                                               cudaStream_t cuStream)
{
   
    return NCV_SUCCESS;
}


NCVStatus ncvGrowDetectionsVector_device(NCVVector<Ncv32u> &pixelMask,
                                         Ncv32u numPixelMaskDetections,
                                         NCVVector<NcvRect32u> &hypotheses,
                                         Ncv32u &totalDetections,
                                         Ncv32u totalMaxDetections,
                                         Ncv32u rectWidth,
                                         Ncv32u rectHeight,
                                         Ncv32f curScale,
                                         cudaStream_t cuStream)
{
    NCVStatus ncvStat = NCV_SUCCESS;
    return ncvStat;
}


//==============================================================================
//
// Pipeline file
//
//==============================================================================


NCVStatus ncvDetectObjectsMultiScale_device(NCVMatrix<Ncv8u> &d_srcImg,
                                            NcvSize32u srcRoi,
                                            NCVVector<NcvRect32u> &d_dstRects,
                                            Ncv32u &dstNumRects,

                                            HaarClassifierCascadeDescriptor &haar,
                                            NCVVector<HaarStage64> &h_HaarStages,
                                            NCVVector<HaarStage64> &d_HaarStages,
                                            NCVVector<HaarClassifierNode128> &d_HaarNodes,
                                            NCVVector<HaarFeature64> &d_HaarFeatures,

                                            NcvSize32u minObjSize,
                                            Ncv32u minNeighbors,      //default 4
                                            Ncv32f scaleStep,         //default 1.2f
                                            Ncv32u pixelStep,         //default 1
                                            Ncv32u flags,             //default NCVPipeObjDet_Default

                                            INCVMemAllocator &gpuAllocator,
                                            INCVMemAllocator &cpuAllocator,
                                            cudaDeviceProp &devProp,
                                            cudaStream_t cuStream)
{
   
    return NCV_SUCCESS;
}


//==============================================================================
//
// Purely Host code: classifier IO, mock-ups
//
//==============================================================================


NCVStatus ncvApplyHaarClassifierCascade_host(NCVMatrix<Ncv32u> &h_integralImage,
                                             NCVMatrix<Ncv32f> &h_weights,
                                             NCVMatrixAlloc<Ncv32u> &h_pixelMask,
                                             Ncv32u &numDetections,
                                             HaarClassifierCascadeDescriptor &haar,
                                             NCVVector<HaarStage64> &h_HaarStages,
                                             NCVVector<HaarClassifierNode128> &h_HaarNodes,
                                             NCVVector<HaarFeature64> &h_HaarFeatures,
                                             NcvBool bMaskElements,
                                             NcvSize32u anchorsRoi,
                                             Ncv32u pixelStep,
                                             Ncv32f scaleArea)
{
  
    return NCV_SUCCESS;
}


NCVStatus ncvGrowDetectionsVector_host(NCVVector<Ncv32u> &pixelMask,
                                       Ncv32u numPixelMaskDetections,
                                       NCVVector<NcvRect32u> &hypotheses,
                                       Ncv32u &totalDetections,
                                       Ncv32u totalMaxDetections,
                                       Ncv32u rectWidth,
                                       Ncv32u rectHeight,
                                       Ncv32f curScale)
{
      return NCV_SUCCESS;
}


NCVStatus loadFromXML(const std::string &filename,
                      HaarClassifierCascadeDescriptor &haar,
                      std::vector<HaarStage64> &haarStages,
                      std::vector<HaarClassifierNode128> &haarClassifierNodes,
                      std::vector<HaarFeature64> &haarFeatures);


NCVStatus ncvHaarGetClassifierSize(const std::string &filename, Ncv32u &numStages,
                                   Ncv32u &numNodes, Ncv32u &numFeatures)
{
    return NCV_SUCCESS;
}


NCVStatus ncvHaarLoadFromFile_host(const std::string &filename,
                                   HaarClassifierCascadeDescriptor &haar,
                                   NCVVector<HaarStage64> &h_HaarStages,
                                   NCVVector<HaarClassifierNode128> &h_HaarNodes,
                                   NCVVector<HaarFeature64> &h_HaarFeatures)
{
     return NCV_SUCCESS;
}


NCVStatus ncvHaarStoreNVBIN_host(const std::string &filename,
                                 HaarClassifierCascadeDescriptor haar,
                                 NCVVector<HaarStage64> &h_HaarStages,
                                 NCVVector<HaarClassifierNode128> &h_HaarNodes,
                                 NCVVector<HaarFeature64> &h_HaarFeatures)
{
   
    return NCV_SUCCESS;
}

#endif /* CUDA_DISABLER */
