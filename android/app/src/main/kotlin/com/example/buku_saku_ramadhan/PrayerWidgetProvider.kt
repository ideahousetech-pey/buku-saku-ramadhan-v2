package com.example.buku_saku_ramadhan

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

class PrayerWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(
                context.packageName,
                R.layout.prayer_widget
            )

            views.setTextViewText(R.id.tvSubuh, "Subuh 04:35")
            views.setTextViewText(R.id.tvDzuhur, "Dzuhur 11:58")
            views.setTextViewText(R.id.tvAshar, "Ashar 15:12")

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
