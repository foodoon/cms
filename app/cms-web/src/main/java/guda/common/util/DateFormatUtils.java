package guda.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateFormatUtils extends org.apache.commons.lang.time.DateFormatUtils{
	private DateFormatUtils(){}
	
	public static String formatDate(Date date){
		return DateFormat.getDateInstance().format(date);
	}
	
	public static String formatTime(Date date){
		return DateFormat.getTimeInstance().format(date);
	}
	
	public static String formatDateTime(Date date){
		if(DateFormat.getDateTimeInstance().format(date).contains("0:00:00")){
			return formatDate(date);
		}
		return DateFormat.getDateTimeInstance().format(date);
	}
	
	public static Date parseTime(Date time){
        Calendar instance = Calendar.getInstance();
        instance.setTime(time);
        instance.set(Calendar.YEAR,2014);
        instance.set(Calendar.MONTH,1);
        instance.set(Calendar.DAY_OF_MONTH,1);
        return instance.getTime();
	}
	
	public static Date parseDate(Date time){
        Calendar instance = Calendar.getInstance();
        instance.setTime(time);
        instance.set(Calendar.HOUR_OF_DAY,0);
        instance.set(Calendar.MINUTE,0);
        instance.set(Calendar.SECOND,0);
        instance.set(Calendar.MILLISECOND,0);

		return instance.getTime();
	}
}
