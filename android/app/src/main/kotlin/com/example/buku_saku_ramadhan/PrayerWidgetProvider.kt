package com.ideahousetech.bukusakuramadhan

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import java.text.SimpleDateFormat
import java.util.*

class PrayerWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {

            val views = RemoteViews(
                context.packageName,
                R.layout.prayer_widget
            )

            // --- DATA SEMENTARA (AMAN)
            val city = "Jakarta"
            val nextPrayer = getNextPrayer()
            val time = getNextPrayerTime()

            views.setTextViewText(R.id.tvCity, city)
            views.setTextViewText(R.id.tvNextPrayer, nextPrayer)
            views.setTextViewText(R.id.tvPrayerTime, time)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun getNextPrayer(): String {
        val hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY)
        return when {
            hour < 5 -> "Subuh"
            hour < 12 -> "Dzuhur"
            hour < 15 -> "Ashar"
            hour < 18 -> "Maghrib"
            else -> "Isya"
        }
    }

    private fun getNextPrayerTime(): String {
        val formatter = SimpleDateFormat("HH:mm", Locale.getDefault())
        return formatter.format(Date())
    }
}
