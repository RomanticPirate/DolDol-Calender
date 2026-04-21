.class public Lcom/doldolcal/CalWidgetFactory;
.super Ljava/lang/Object;
.implements Landroid/widget/RemoteViewsService$RemoteViewsFactory;

.field private mContext:Landroid/content/Context;
.field private mWidgetId:I
.field private mYear:I
.field private mMonth:I
.field private mDayColor:I
.field private mEventTitles:[Ljava/lang/String;
.field private mEventColors:[I
.field private mWeeks:Ljava/util/ArrayList;

.method public constructor <init>(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;

    const v0, 0xff1A1A2E
    iput v0, p0, Lcom/doldolcal/CalWidgetFactory;->mDayColor:I

    const-string v0, "appWidgetId"
    const/4 v1, 0x0
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalWidgetFactory;->mWidgetId:I

    const-string v0, "year"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalWidgetFactory;->mYear:I

    const-string v0, "month"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalWidgetFactory;->mMonth:I

    const/16 v0, 0x20
    new-array v0, v0, [Ljava/lang/String;
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;

    const/16 v0, 0x20
    new-array v0, v0, [I
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I

    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    return-void
.end method

.method public onCreate()V
    .locals 0
    return-void
.end method

.method public onDestroy()V
    .locals 0
    return-void
.end method

# Load events for displayed year/month into mEventTitles / mEventColors
.method private loadEvents(II)V
    .locals 13

    # Clear arrays
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    const/4 v1, 0x0
    const/16 v2, 0x20
    const/4 v3, 0x0
    :clr_loop
    if-ge v1, v2, :clr_done
    aput-object v3, v0, v1
    add-int/lit8 v1, v1, 0x1
    goto :clr_loop
    :clr_done

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    const/4 v1, 0x0
    :clr_loop2
    if-ge v1, v2, :clr_done2
    const/4 v3, 0x0
    aput v3, v0, v1
    add-int/lit8 v1, v1, 0x1
    goto :clr_loop2
    :clr_done2

    :try_start
    # Build month key "YYYY-MM" (month is 0-based)
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, "-"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    add-int/lit8 v2, p2, 0x1
    const/16 v1, 0xa
    if-ge v2, v1, :mk_two
    const-string v1, "0"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :mk_two
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    # v0 = monthKey "YYYY-MM"

    # Get SharedPreferences
    iget-object v1, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v2, "widget_prefs"
    const/4 v3, 0x0
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v1

    # Read events_<monthKey>
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "events_"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, ""
    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    # v0 = events string

    if-eqz v0, :l_done
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :l_done

    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0

    array-length v1, v0
    const/4 v2, 0x0

    :ev_loop
    if-ge v2, v1, :l_done

    aget-object v3, v0, v2
    if-eqz v3, :ev_next
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z
    move-result v4
    if-nez v4, :ev_next

    const-string v4, "\\|"
    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v3

    array-length v4, v3
    const/4 v5, 0x3
    if-lt v4, v5, :ev_next

    const/4 v4, 0x0
    aget-object v4, v3, v4
    # v4 = "YYYY-MM-DD"

    # Get day: substring(8) → parseInt
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v5
    const/16 v6, 0xa
    if-lt v5, v6, :ev_next

    const/16 v5, 0x8
    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v4

    :try_inner_s
    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v4
    :try_inner_e
    .catch Ljava/lang/Exception; {:try_inner_s .. :try_inner_e} :ev_skip_parse

    const/4 v5, 0x1
    if-lt v4, v5, :ev_next
    const/16 v5, 0x1f
    if-gt v4, v5, :ev_next

    add-int/lit8 v4, v4, -0x1
    # v4 = index (day - 1)

    const/4 v5, 0x1
    aget-object v5, v3, v5
    iget-object v6, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    aput-object v5, v6, v4

    const/4 v5, 0x2
    aget-object v5, v3, v5

    :try_col_s
    invoke-static {v5}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I
    move-result v5
    :try_col_e
    .catch Ljava/lang/Exception; {:try_col_s .. :try_col_e} :col_default
    goto :col_store
    :col_default
    move-exception v6
    const v5, -0x94959a

    :col_store
    iget-object v6, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    aput v5, v6, v4
    goto :ev_next

    :ev_skip_parse
    move-exception v5

    :ev_next
    add-int/lit8 v2, v2, 0x1
    goto :ev_loop

    :l_done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :l_catch

    return-void

    :l_catch
    move-exception v0
    return-void
.end method

.method public onDataSetChanged()V
    .locals 11

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    # Read style pref -> set mDayColor
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v1, "widget_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "style_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v2, p0, Lcom/doldolcal/CalWidgetFactory;->mWidgetId:I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "white"
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    const-string v1, "black"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :_white_theme
    const v1, -0x1
    goto :_color_done
    :_white_theme
    const v1, 0xff1A1A2E
    :_color_done
    iput v1, p0, Lcom/doldolcal/CalWidgetFactory;->mDayColor:I

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;

    # Read displayed year/month (fallback to current if -1)
    iget v2, p0, Lcom/doldolcal/CalWidgetFactory;->mYear:I
    iget v3, p0, Lcom/doldolcal/CalWidgetFactory;->mMonth:I

    new-instance v1, Ljava/util/GregorianCalendar;
    invoke-direct {v1}, Ljava/util/GregorianCalendar;-><init>()V

    const/4 v4, -0x1
    if-ne v2, v4, :has_y
    const/4 v4, 0x1
    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I
    move-result v2
    :has_y

    const/4 v4, -0x1
    if-ne v3, v4, :has_m
    const/4 v4, 0x2
    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I
    move-result v3
    :has_m

    # Load events for this month
    invoke-direct {p0, v2, v3}, Lcom/doldolcal/CalWidgetFactory;->loadEvents(II)V

    new-instance v4, Ljava/util/GregorianCalendar;
    const/4 v5, 0x1
    invoke-direct {v4, v2, v3, v5}, Ljava/util/GregorianCalendar;-><init>(III)V

    const/4 v5, 0x7
    invoke-virtual {v4, v5}, Ljava/util/Calendar;->get(I)I
    move-result v5
    add-int/lit8 v5, v5, -0x1

    const/4 v6, 0x5
    invoke-virtual {v4, v6}, Ljava/util/Calendar;->getActualMaximum(I)I
    move-result v6

    const/4 v7, 0x1
    invoke-virtual {v1, v7}, Ljava/util/Calendar;->get(I)I
    move-result v7
    const/4 v4, 0x2
    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I
    move-result v4
    if-ne v7, v2, :not_current
    if-ne v4, v3, :not_current
    const/4 v4, 0x5
    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I
    move-result v7
    goto :today_done
    :not_current
    const/4 v7, 0x0
    :today_done

    const/4 v8, 0x1
    sub-int v8, v8, v5

    const/4 v9, 0x0
    const/4 v10, 0x6
    :week_loop
    if-ge v9, v10, :week_done

    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0
    const/4 v5, 0x7
    :day_loop
    if-ge v1, v5, :day_done

    if-lez v8, :prev_month
    if-gt v8, v6, :next_month

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    goto :day_sep

    :prev_month
    const-string v11, "0"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :day_sep

    :next_month
    const-string v11, "0"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :day_sep
    const/4 v11, 0x6
    if-ge v1, v11, :no_comma
    const-string v11, ","
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :no_comma
    add-int/lit8 v8, v8, 0x1
    add-int/lit8 v1, v1, 0x1
    goto :day_loop

    :day_done
    const-string v11, "|"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v9, v9, 0x1
    goto :week_loop

    :week_done
    return-void
.end method

.method public getCount()I
    .locals 1
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
    move-result v0
    return v0
.end method

.method public getViewAt(I)Landroid/widget/RemoteViews;
    .locals 13

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0

    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040001
    invoke-direct {v1, v0, v2}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    # Read font size pref
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v2, "widget_prefs"
    const/4 v12, 0x0
    invoke-virtual {v0, v2, v12}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v11, "fontsize_"
    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v11, p0, Lcom/doldolcal/CalWidgetFactory;->mWidgetId:I
    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v11, "normal"
    invoke-interface {v0, v2, v11}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    const-string v2, "large"
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :norm_size
    const v11, 0x41a80000
    goto :size_done
    :norm_size
    const v11, 0x41300000
    :size_done

    # Parse week data
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Ljava/lang/String;

    const-string v2, "\\|"
    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v2

    const/4 v3, 0x0
    aget-object v3, v2, v3
    const-string v4, ","
    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v3

    const/4 v4, 0x1
    aget-object v4, v2, v4
    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v4

    const/4 v5, 0x7
    new-array v5, v5, [I
    fill-array-data v5, :day_ids

    # Event row state: will show evt_row0 if any events in this week
    const/4 v2, 0x0
    # v2 = hasEvent flag (using register later; reset here)

    const/4 v6, 0x0
    :set_loop
    const/4 v10, 0x7
    if-ge v6, v10, :set_done

    aget v7, v5, v6
    aget-object v8, v3, v6

    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v9

    const/4 v12, 0x2
    invoke-virtual {v1, v7, v12, v11}, Landroid/widget/RemoteViews;->setTextViewTextSize(IIF)V

    if-nez v9, :valid_day

    const-string v8, ""
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v8, 0x30999999
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :next_d

    :valid_day
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    if-nez v6, :not_sun
    const v8, 0xffFF6B6B
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :chk_today

    :not_sun
    const/4 v10, 0x6
    if-ne v6, v10, :norm_color
    const v8, 0xff5B6AFF
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :chk_today

    :norm_color
    iget v8, p0, Lcom/doldolcal/CalWidgetFactory;->mDayColor:I
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V

    :chk_today
    if-ne v9, v4, :next_d
    new-instance v8, Ljava/lang/StringBuilder;
    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V
    const-string v10, "["
    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    aget-object v10, v3, v6
    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v10, "]"
    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    :next_d
    add-int/lit8 v6, v6, 0x1
    goto :set_loop

    :set_done

    # ─── Event labels row ───
    const/4 v6, 0x0
    const/4 v2, 0x0
    # v2 = hasEvent flag
    :evt_loop
    const/4 v10, 0x7
    if-ge v6, v10, :evt_done

    aget-object v8, v3, v6
    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v9

    # Compute evt0_N id = 0x7f060010 + v6
    const v7, 0x7f060010
    add-int/2addr v7, v6

    if-lez v9, :evt_clear

    # Check event for this day: idx = day - 1
    add-int/lit8 v10, v9, -0x1
    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    aget-object v4, v4, v10
    if-eqz v4, :evt_clear

    # Has event: set text + bg color
    invoke-virtual {v1, v7, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    aget v10, v4, v10
    const-string v4, "setBackgroundColor"
    invoke-virtual {v1, v7, v4, v10}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    # White text on colored bg
    const v4, -0x1
    invoke-virtual {v1, v7, v4}, Landroid/widget/RemoteViews;->setTextColor(II)V

    const/4 v2, 0x1
    goto :evt_next

    :evt_clear
    const-string v4, ""
    invoke-virtual {v1, v7, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const/4 v4, 0x0
    const-string v10, "setBackgroundColor"
    invoke-virtual {v1, v7, v10, v4}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    :evt_next
    add-int/lit8 v6, v6, 0x1
    goto :evt_loop

    :evt_done
    # Show/hide evt_row0 based on hasEvent
    const v4, 0x7f06000f
    if-eqz v2, :row_hide
    const/4 v6, 0x0
    invoke-virtual {v1, v4, v6}, Landroid/widget/RemoteViews;->setViewVisibility(II)V
    goto :row_done
    :row_hide
    const/16 v6, 0x8
    invoke-virtual {v1, v4, v6}, Landroid/widget/RemoteViews;->setViewVisibility(II)V
    :row_done

    return-object v1

    :day_ids
    .array-data 4
        0x7f060008
        0x7f060009
        0x7f06000a
        0x7f06000b
        0x7f06000c
        0x7f06000d
        0x7f06000e
    .end array-data
.end method

.method public getItemId(I)J
    .locals 2
    int-to-long v0, p1
    return-wide v0
.end method

.method public getLoadingView()Landroid/widget/RemoteViews;
    .locals 1
    const/4 v0, 0x0
    return-object v0
.end method

.method public getViewTypeCount()I
    .locals 1
    const/4 v0, 0x1
    return v0
.end method

.method public hasStableIds()Z
    .locals 1
    const/4 v0, 0x1
    return v0
.end method
