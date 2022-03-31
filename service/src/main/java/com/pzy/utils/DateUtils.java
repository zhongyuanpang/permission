package com.pzy.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author Nice
 * @Date 2021/9/9 21:58
 * 日期工具类
 */

public class DateUtils {
    /**
     * 返回当前的年月字符串，示例：2021-08
     * @return 年月字符串
     */
    public static String getYearMonth(){
        //yyyyMMdd
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        return sdf.format(new Date());
    }
}
