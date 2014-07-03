// This file is part of OpenCV project.
// It is subject to the license terms in the LICENSE file found in the top-level directory
// of this distribution and at http://opencv.org/license.html.

// Copyright (C) 2014, Itseez, Inc., all rights reserved.
// Third party copyrights are property of their respective owners.

#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif

#define TSIZE (int)sizeof(T)

__kernel void gemm(__global const uchar * aptr, int a_step, int a_offset, int a_rows, int a_cols,
                   __global const uchar * bptr, int b_step, int b_offset, int b_rows, int b_cols,
#ifdef HAVE_C
                   __global const uchar * cptr, int c_step, int c_offset, int c_rows, int c_cols,
#endif
                   __global const uchar * dptr, int d_step, int d_offset, int d_rows, int d_cols,
                   float alpha
#ifdef HAVE_C
                   , float beta
#endif
                   )
{
    __local T parts[BLOCK_SIZE_0];

    int lid = get_local_id(0);
    int gx0 = get_group_id(0) * BLOCK_SIZE_0, gy0 = get_group_id(1) * BLOCK_SIZE_1;
    int gx1 = min(d_cols, gx0 + BLOCK_SIZE_0), gy1 = min(d_rows, gy0 + BLOCK_SIZE_1);

    for ( ; gy0 < gy1; ++gy0)
        for ( ; gx0 < gx1; ++gx0)
        {
            T result = (T)(0);

            for (int x = 0; x < a_cols; x += BLOCK_SIZE_0)
                ; // multcds

            result +=
#ifdef HAVE_C
#ifdef HAVE_BETA
                beta * *(__global const T *)(cptr + mad24(gy0, c_step, mad24(gx0, TSIZE, c_offset)));
#else
                *(__global const T *)(cptr + mad24(gy0, c_step, mad24(gx0, TSIZE, c_offset)));
#endif
#else
                (T)(0);
#endif

            if (lid == 0)
            {

            }
        }
}
