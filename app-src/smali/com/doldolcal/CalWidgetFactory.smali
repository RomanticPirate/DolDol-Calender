.class public Lcom/doldolcal/CalWidgetFactory;
.super Ljava/lang/Object;
.implements Landroid/widget/RemoteViewsService$RemoteViewsFactory;

.field private mContext:Landroid/content/Context;
.field private mWeeks:Ljava/util/ArrayList;

.method public constructor <init>(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
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

.method public onDataSetChanged()V
    .locals 11

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    new-instance v1, Ljava/util/GregorianCalendar;
    invoke-direct {v1}, Ljava/util/GregorianCalendar;-><init>()V

    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I
    move-result v2

    const/4 v3, 0x2
    invoke-virtual {v1, v3}, Ljava/util/Calendar;->get(I)I
    move-result v3

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

    const/4 v7, 0x5
    invoke-virtual {v1, v7}, Ljava/util/Calendar;->get(I)I
    move-result v7

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
    .locals 11

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0

    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040002
    invoke-direct {v1, v0, v2}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

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

    # Day view IDs
    const/4 v5, 0x7
    new-array v5, v5, [I
    fill-array-data v5, :day_ids

    # Loop 7 days
    const/4 v6, 0x0
    :set_loop
    const/4 v10, 0x7
    if-ge v6, v10, :set_done

    aget v7, v5, v6
    aget-object v8, v3, v6

    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v9

    if-nez v9, :valid_day

    const-string v8, ""
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v8, 0x30999999
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :next_d

    :valid_day
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    # Sunday (index 0) = red
    if-nez v6, :not_sun
    const v8, 0xffFF6B6B
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :chk_today

    :not_sun
    # Saturday (index 6) = blue
    const/4 v10, 0x6
    if-ne v6, v10, :norm_color
    const v8, 0xff5B6AFF
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :chk_today

    :norm_color
    const v8, 0xff1A1A2E
    invoke-virtual {v1, v7, v8}, Landroid/widget/RemoteViews;->setTextColor(II)V

    :chk_today
    if-ne v9, v4, :next_d
    # Mark today with brackets
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
