/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Yasamin/Documents/Classes/COE758/CacheController-master/SDRAMController.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);
char *ieee_p_1242562249_sub_180853171_1035706684(char *, char *, int , int );


static void work_a_2696732300_3212880686_p_0(char *t0)
{
    char t18[16];
    char t40[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    int t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    char *t19;
    char *t20;
    char *t21;
    int t22;
    int t23;
    unsigned int t24;
    unsigned int t25;
    char *t26;
    int t27;
    int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;

LAB0:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3632);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(27, ng0);
    t4 = (t0 + 2152U);
    t8 = *((char **)t4);
    t9 = *((int *)t8);
    t10 = (t9 == 0);
    if (t10 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(37, ng0);
    t2 = (t0 + 1512U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB21;

LAB23:
LAB22:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(28, ng0);
    t4 = (t0 + 8688);
    *((int *)t4) = 0;
    t11 = (t0 + 8692);
    *((int *)t11) = 7;
    t12 = 0;
    t13 = 7;

LAB11:    if (t12 <= t13)
        goto LAB12;

LAB14:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 3776);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((int *)t11) = 1;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB12:    xsi_set_current_line(29, ng0);
    t14 = (t0 + 8696);
    *((int *)t14) = 0;
    t15 = (t0 + 8700);
    *((int *)t15) = 31;
    t16 = 0;
    t17 = 31;

LAB15:    if (t16 <= t17)
        goto LAB16;

LAB18:
LAB13:    t2 = (t0 + 8688);
    t12 = *((int *)t2);
    t4 = (t0 + 8692);
    t13 = *((int *)t4);
    if (t12 == t13)
        goto LAB14;

LAB20:    t9 = (t12 + 1);
    t12 = t9;
    t5 = (t0 + 8688);
    *((int *)t5) = t12;
    goto LAB11;

LAB16:    xsi_set_current_line(30, ng0);
    t19 = (t0 + 8696);
    t20 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t18, *((int *)t19), 8);
    t21 = (t0 + 8688);
    t22 = *((int *)t21);
    t23 = (t22 - 7);
    t24 = (t23 * -1);
    t25 = (t24 * 32U);
    t26 = (t0 + 8696);
    t27 = *((int *)t26);
    t28 = (t27 - 31);
    t29 = (t28 * -1);
    t30 = (t25 + t29);
    t31 = (8U * t30);
    t32 = (0U + t31);
    t33 = (t0 + 3712);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    memcpy(t37, t20, 8U);
    xsi_driver_first_trans_delta(t33, t32, 8U, 0LL);

LAB17:    t2 = (t0 + 8696);
    t16 = *((int *)t2);
    t4 = (t0 + 8700);
    t17 = *((int *)t4);
    if (t16 == t17)
        goto LAB18;

LAB19:    t9 = (t16 + 1);
    t16 = t9;
    t5 = (t0 + 8696);
    *((int *)t5) = t16;
    goto LAB15;

LAB21:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1352U);
    t5 = *((char **)t2);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB24;

LAB26:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1992U);
    t4 = *((char **)t2);
    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t24 = (15 - 7);
    t25 = (t24 * 1U);
    t29 = (0 + t25);
    t2 = (t5 + t29);
    t8 = (t18 + 0U);
    t11 = (t8 + 0U);
    *((int *)t11) = 7;
    t11 = (t8 + 4U);
    *((int *)t11) = 5;
    t11 = (t8 + 8U);
    *((int *)t11) = -1;
    t9 = (5 - 7);
    t30 = (t9 * -1);
    t30 = (t30 + 1);
    t11 = (t8 + 12U);
    *((unsigned int *)t11) = t30;
    t12 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t18);
    t13 = (t12 - 7);
    t30 = (t13 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t12);
    t31 = (t30 * 32U);
    t11 = (t0 + 1192U);
    t14 = *((char **)t11);
    t32 = (15 - 4);
    t38 = (t32 * 1U);
    t39 = (0 + t38);
    t11 = (t14 + t39);
    t15 = (t40 + 0U);
    t19 = (t15 + 0U);
    *((int *)t19) = 4;
    t19 = (t15 + 4U);
    *((int *)t19) = 0;
    t19 = (t15 + 8U);
    *((int *)t19) = -1;
    t16 = (0 - 4);
    t41 = (t16 * -1);
    t41 = (t41 + 1);
    t19 = (t15 + 12U);
    *((unsigned int *)t19) = t41;
    t17 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t11, t40);
    t22 = (t17 - 31);
    t41 = (t22 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t17);
    t42 = (t31 + t41);
    t43 = (8U * t42);
    t44 = (0 + t43);
    t19 = (t4 + t44);
    t20 = (t0 + 3840);
    t21 = (t20 + 56U);
    t26 = *((char **)t21);
    t33 = (t26 + 56U);
    t34 = *((char **)t33);
    memcpy(t34, t19, 8U);
    xsi_driver_first_trans_fast_port(t20);

LAB25:    goto LAB22;

LAB24:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 1672U);
    t8 = *((char **)t2);
    t2 = (t0 + 1192U);
    t11 = *((char **)t2);
    t24 = (15 - 7);
    t25 = (t24 * 1U);
    t29 = (0 + t25);
    t2 = (t11 + t29);
    t14 = (t18 + 0U);
    t15 = (t14 + 0U);
    *((int *)t15) = 7;
    t15 = (t14 + 4U);
    *((int *)t15) = 5;
    t15 = (t14 + 8U);
    *((int *)t15) = -1;
    t9 = (5 - 7);
    t30 = (t9 * -1);
    t30 = (t30 + 1);
    t15 = (t14 + 12U);
    *((unsigned int *)t15) = t30;
    t12 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t18);
    t13 = (t12 - 7);
    t30 = (t13 * -1);
    t31 = (t30 * 32U);
    t15 = (t0 + 1192U);
    t19 = *((char **)t15);
    t32 = (15 - 4);
    t38 = (t32 * 1U);
    t39 = (0 + t38);
    t15 = (t19 + t39);
    t20 = (t40 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 4;
    t21 = (t20 + 4U);
    *((int *)t21) = 0;
    t21 = (t20 + 8U);
    *((int *)t21) = -1;
    t16 = (0 - 4);
    t41 = (t16 * -1);
    t41 = (t41 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t41;
    t17 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t15, t40);
    t22 = (t17 - 31);
    t41 = (t22 * -1);
    t42 = (t31 + t41);
    t43 = (8U * t42);
    t44 = (0U + t43);
    t21 = (t0 + 3712);
    t26 = (t21 + 56U);
    t33 = *((char **)t26);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memcpy(t35, t8, 8U);
    xsi_driver_first_trans_delta(t21, t44, 8U, 0LL);
    goto LAB25;

}


extern void work_a_2696732300_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2696732300_3212880686_p_0};
	xsi_register_didat("work_a_2696732300_3212880686", "isim/cache_test_isim_beh.exe.sim/work/a_2696732300_3212880686.didat");
	xsi_register_executes(pe);
}
