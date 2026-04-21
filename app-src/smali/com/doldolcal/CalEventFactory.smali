.class public Lcom/doldolcal/CalEventFactory;
.super Ljava/lang/Object;
.implements Landroid/widget/RemoteViewsService$RemoteViewsFactory;

.field private mContext:Landroid/content/Context;
.field private mWidgetId:I
.field private mYear:I
.field private mMonth:I
.field private mTextColor:I
.field private mScale:F
.field private mSelectedDate:Ljava/lang/String;
.field private mDays:[I
.field private mTitles:[Ljava/lang/String;
.field private mColors:[I
.field private mMetas:[Ljava/lang/String;
.field private mEventIds:[Ljava/lang/String;
.field private mCount:I

.method public constructor <init>(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/CalEventFactory;->mContext:Landroid/content/Context;

    const v0, 0xff1A1A2E
    iput v0, p0, Lcom/doldolcal/CalEventFactory;->mTextColor:I

    const v0, 0x3f800000
    iput v0, p0, Lcom/doldolcal/CalEventFactory;->mScale:F

    const-string v0, "appWidgetId"
    const/4 v1, 0x0
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalEventFactory;->mWidgetId:I

    const-string v0, "year"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalEventFactory;->mYear:I

    const-string v0, "month"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v2
    iput v2, p0, Lcom/doldolcal/CalEventFactory;->mMonth:I

    const/16 v0, 0x80
    new-array v0, v0, [I
    iput-object v0, p0, Lcom/doldolcal/CalEventFactory;->mDays:[I

    const/16 v0, 0x80
    new-array v0, v0, [Ljava/lang/String;
    iput-object v0, p0, Lcom/doldolcal/CalEventFactory;->mTitles:[Ljava/lang/String;

    const/16 v0, 0x80
    new-array v0, v0, [I
    iput-object v0, p0, Lcom/doldolcal/CalEventFactory;->mColors:[I

    const/16 v0, 0x80
    new-array v0, v0, [Ljava/lang/String;
    iput-object v0, p0, Lcom/doldolcal/CalEventFactory;->mMetas:[Ljava/lang/String;

    const/16 v0, 0x80
    new-array v0, v0, [Ljava/lang/String;
    iput-object v0, p0, Lcom/doldolcal/CalEventFactory;->mEventIds:[Ljava/lang/String;

    const/4 v0, 0x0
    iput v0, p0, Lcom/doldolcal/CalEventFactory;->mCount:I

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

# Parses events_<YYYY-MM> from prefs into the arrays; sets mCount
.method private parseEvents(Landroid/content/SharedPreferences;II)V
    .locals 11

    # Build month key "YYYY-MM"
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, "-"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    add-int/lit8 v1, p3, 0x1
    const/16 v2, 0xa
    if-ge v1, v2, :_pad
    const-string v2, "0"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_pad
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0

    # Read events_<monthKey>
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "events_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, ""
    invoke-interface {p1, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    const/4 v3, 0x0
    # v3 = out count (init to 0 before any early-exit path)

    if-eqz v0, :_done
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :_done

    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0
    # v0 = lines[]

    array-length v1, v0
    const/4 v2, 0x0
    # v2 = i

    :_lp
    if-ge v2, v1, :_done
    const/16 v4, 0x80
    if-ge v3, v4, :_done

    aget-object v4, v0, v2
    invoke-direct {p0, v4, v3}, Lcom/doldolcal/CalEventFactory;->parseOneLine(Ljava/lang/String;I)Z
    move-result v4
    if-eqz v4, :_nx
    add-int/lit8 v3, v3, 0x1
    :_nx
    add-int/lit8 v2, v2, 0x1
    goto :_lp

    :_done
    iput v3, p0, Lcom/doldolcal/CalEventFactory;->mCount:I
    return-void
.end method

# Parse one "YYYY-MM-DD|title|color" line; store at idx; return true if stored
.method private parseOneLine(Ljava/lang/String;I)Z
    .locals 6

    if-nez p1, :_ok
    const/4 v0, 0x0
    return v0
    :_ok

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :_ne
    const/4 v0, 0x0
    return v0
    :_ne

    const-string v0, "\\|"
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0

    array-length v1, v0
    const/4 v2, 0x3
    if-ge v1, v2, :_len_ok
    const/4 v0, 0x0
    return v0
    :_len_ok

    const/4 v1, 0x0
    aget-object v1, v0, v1
    # v1 = date string

    iget-object v4, p0, Lcom/doldolcal/CalEventFactory;->mSelectedDate:Ljava/lang/String;
    if-eqz v4, :_flt_ok
    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-nez v4, :_flt_ok
    const/4 v0, 0x0
    return v0
    :_flt_ok

    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, 0xa
    if-ge v2, v3, :_dlen_ok
    const/4 v0, 0x0
    return v0
    :_dlen_ok

    const/16 v2, 0x8
    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v1

    :try_d_s
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v1
    :try_d_e
    .catch Ljava/lang/Exception; {:try_d_s .. :try_d_e} :_d_fail

    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mDays:[I
    aput v1, v2, p2

    const/4 v1, 0x1
    aget-object v1, v0, v1
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mTitles:[Ljava/lang/String;
    aput-object v1, v2, p2

    const/4 v1, 0x2
    aget-object v1, v0, v1
    invoke-direct {p0, v1}, Lcom/doldolcal/CalEventFactory;->safeColor(Ljava/lang/String;)I
    move-result v1
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mColors:[I
    aput v1, v2, p2

    # meta (field 3) if present
    array-length v1, v0
    const/4 v2, 0x4
    if-lt v1, v2, :_no_meta
    const/4 v1, 0x3
    aget-object v1, v0, v1
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mMetas:[Ljava/lang/String;
    aput-object v1, v2, p2
    goto :_aft_meta
    :_no_meta
    const-string v1, ""
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mMetas:[Ljava/lang/String;
    aput-object v1, v2, p2
    :_aft_meta

    # eventId (field 4) if present
    array-length v1, v0
    const/4 v2, 0x5
    if-lt v1, v2, :_no_eid
    const/4 v1, 0x4
    aget-object v1, v0, v1
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mEventIds:[Ljava/lang/String;
    aput-object v1, v2, p2
    goto :_stored
    :_no_eid
    const-string v1, ""
    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mEventIds:[Ljava/lang/String;
    aput-object v1, v2, p2

    :_stored
    const/4 v0, 0x1
    return v0

    :_d_fail
    move-exception v0
    const/4 v0, 0x0
    return v0
.end method

.method private resolveSelectedDate()Ljava/lang/String;
    .locals 6

    iget-object v0, p0, Lcom/doldolcal/CalEventFactory;->mContext:Landroid/content/Context;
    const-string v1, "widget_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "selected_date_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v2, p0, Lcom/doldolcal/CalEventFactory;->mWidgetId:I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    if-eqz v0, :_tod
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :_tod
    return-object v0

    :_tod
    new-instance v0, Ljava/util/GregorianCalendar;
    invoke-direct {v0}, Ljava/util/GregorianCalendar;-><init>()V
    const/4 v1, 0x1
    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I
    move-result v1
    const/4 v2, 0x2
    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I
    move-result v2
    add-int/lit8 v2, v2, 0x1
    const/4 v3, 0x5
    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I
    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, "-"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/16 v5, 0xa
    if-ge v2, v5, :_m2
    const-string v5, "0"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_m2
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, "-"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/16 v5, 0xa
    if-ge v3, v5, :_d2
    const-string v5, "0"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_d2
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    return-object v4
.end method

.method private safeColor(Ljava/lang/String;)I
    .locals 2
    :try_s
    invoke-static {p1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I
    move-result v0
    :try_e
    .catch Ljava/lang/Exception; {:try_s .. :try_e} :_f
    return v0
    :_f
    move-exception v1
    const v0, 0xff5B6AFF
    return v0
.end method

.method public onDataSetChanged()V
    .locals 13

    const/4 v0, 0x0
    iput v0, p0, Lcom/doldolcal/CalEventFactory;->mCount:I

    # Read text color based on style
    iget-object v0, p0, Lcom/doldolcal/CalEventFactory;->mContext:Landroid/content/Context;
    const-string v1, "widget_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "style_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v2, p0, Lcom/doldolcal/CalEventFactory;->mWidgetId:I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "white"
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1

    const-string v2, "black"
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :_wc
    const v1, -0x1
    goto :_ccd
    :_wc
    const v1, 0xff1A1A2E
    :_ccd
    iput v1, p0, Lcom/doldolcal/CalEventFactory;->mTextColor:I

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "scale_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v2, p0, Lcom/doldolcal/CalEventFactory;->mWidgetId:I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const v2, 0x3f800000
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v1
    iput v1, p0, Lcom/doldolcal/CalEventFactory;->mScale:F

    # Resolve year/month (fallback current)
    iget v1, p0, Lcom/doldolcal/CalEventFactory;->mYear:I
    iget v2, p0, Lcom/doldolcal/CalEventFactory;->mMonth:I

    new-instance v3, Ljava/util/GregorianCalendar;
    invoke-direct {v3}, Ljava/util/GregorianCalendar;-><init>()V
    const/4 v4, -0x1
    if-ne v1, v4, :_hy
    const/4 v4, 0x1
    invoke-virtual {v3, v4}, Ljava/util/Calendar;->get(I)I
    move-result v1
    :_hy
    const/4 v4, -0x1
    if-ne v2, v4, :_hm
    const/4 v4, 0x2
    invoke-virtual {v3, v4}, Ljava/util/Calendar;->get(I)I
    move-result v2
    :_hm

    invoke-direct {p0}, Lcom/doldolcal/CalEventFactory;->resolveSelectedDate()Ljava/lang/String;
    move-result-object v3
    iput-object v3, p0, Lcom/doldolcal/CalEventFactory;->mSelectedDate:Ljava/lang/String;

    :try_s
    invoke-direct {p0, v0, v1, v2}, Lcom/doldolcal/CalEventFactory;->parseEvents(Landroid/content/SharedPreferences;II)V
    :try_e
    .catch Ljava/lang/Exception; {:try_s .. :try_e} :_lc

    return-void

    :_lc
    move-exception v0
    return-void
.end method

.method public getCount()I
    .locals 1
    iget v0, p0, Lcom/doldolcal/CalEventFactory;->mCount:I
    return v0
.end method

.method public getViewAt(I)Landroid/widget/RemoteViews;
    .locals 8

    iget-object v0, p0, Lcom/doldolcal/CalEventFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0

    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040002
    invoke-direct {v1, v0, v2}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    iget v0, p0, Lcom/doldolcal/CalEventFactory;->mCount:I
    if-lt p1, v0, :_ok
    return-object v1
    :_ok

    iget-object v0, p0, Lcom/doldolcal/CalEventFactory;->mDays:[I
    aget v0, v0, p1
    # v0 = day

    iget-object v2, p0, Lcom/doldolcal/CalEventFactory;->mTitles:[Ljava/lang/String;
    aget-object v2, v2, p1
    # v2 = title

    iget-object v3, p0, Lcom/doldolcal/CalEventFactory;->mColors:[I
    aget v3, v3, p1
    # v3 = color

    # Build date string "M/D"
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    iget v5, p0, Lcom/doldolcal/CalEventFactory;->mMonth:I
    const/4 v6, -0x1
    if-ne v5, v6, :_hm2
    new-instance v6, Ljava/util/GregorianCalendar;
    invoke-direct {v6}, Ljava/util/GregorianCalendar;-><init>()V
    const/4 v7, 0x2
    invoke-virtual {v6, v7}, Ljava/util/Calendar;->get(I)I
    move-result v5
    :_hm2
    add-int/lit8 v5, v5, 0x1
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, "/"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4

    # widget_evt_date
    const v5, 0x7f060021
    invoke-virtual {v1, v5, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    iget v6, p0, Lcom/doldolcal/CalEventFactory;->mTextColor:I
    invoke-virtual {v1, v5, v6}, Landroid/widget/RemoteViews;->setTextColor(II)V

    # widget_evt_title
    const v5, 0x7f060022
    invoke-virtual {v1, v5, v2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    invoke-virtual {v1, v5, v6}, Landroid/widget/RemoteViews;->setTextColor(II)V

    # widget_evt_meta
    iget-object v7, p0, Lcom/doldolcal/CalEventFactory;->mMetas:[Ljava/lang/String;
    aget-object v7, v7, p1
    if-nez v7, :_has_mt
    const-string v7, ""
    :_has_mt
    const v5, 0x7f06003a
    invoke-virtual {v1, v5, v7}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    # widget_evt_bar background color
    const v5, 0x7f060020
    const-string v6, "setBackgroundColor"
    invoke-virtual {v1, v5, v6, v3}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    # Fill-in intent: open_day + open_event_id on root
    new-instance v3, Landroid/content/Intent;
    invoke-direct {v3}, Landroid/content/Intent;-><init>()V
    const-string v4, "open_day"
    invoke-virtual {v3, v4, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v4, p0, Lcom/doldolcal/CalEventFactory;->mEventIds:[Ljava/lang/String;
    aget-object v4, v4, p1
    if-eqz v4, :_no_eid_fi
    const-string v5, "open_event_id"
    invoke-virtual {v3, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    :_no_eid_fi

    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "content://com.doldolcal/evt/"
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v5
    invoke-virtual {v3, v5}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const v5, 0x7f06003b
    invoke-virtual {v1, v5, v3}, Landroid/widget/RemoteViews;->setOnClickFillInIntent(ILandroid/content/Intent;)V

    # Apply widget scale to font sizes
    iget v3, p0, Lcom/doldolcal/CalEventFactory;->mScale:F
    const/4 v2, 0x2
    const v0, 0x7f060021
    const v4, 0x41200000
    mul-float v4, v4, v3
    invoke-virtual {v1, v0, v2, v4}, Landroid/widget/RemoteViews;->setTextViewTextSize(IIF)V
    const v0, 0x7f060022
    const v4, 0x41400000
    mul-float v4, v4, v3
    invoke-virtual {v1, v0, v2, v4}, Landroid/widget/RemoteViews;->setTextViewTextSize(IIF)V
    const v0, 0x7f06003a
    const v4, 0x41200000
    mul-float v4, v4, v3
    invoke-virtual {v1, v0, v2, v4}, Landroid/widget/RemoteViews;->setTextViewTextSize(IIF)V

    return-object v1
.end method

.method public getItemId(I)J
    .locals 2
    int-to-long v0, p1
    return-wide v0
.end method

.method public getLoadingView()Landroid/widget/RemoteViews;
    .locals 3
    iget-object v0, p0, Lcom/doldolcal/CalEventFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040002
    invoke-direct {v1, v0, v2}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V
    return-object v1
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
