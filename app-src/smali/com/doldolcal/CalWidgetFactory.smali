.class public Lcom/doldolcal/CalWidgetFactory;
.super Ljava/lang/Object;
.implements Landroid/widget/RemoteViewsService$RemoteViewsFactory;

.field private mContext:Landroid/content/Context;
.field private mWidgetId:I
.field private mYear:I
.field private mMonth:I
.field private mDayColor:I
.field private mSelectedDate:Ljava/lang/String;
.field private mEventTitles:[Ljava/lang/String;
.field private mEventColors:[I
.field private mEventCounts:[I
.field private mWeeks:Ljava/util/ArrayList;

# Flat layout: for day d (1..31), slot s (0..3), index = (d-1)*4 + s
# Total capacity 32*4 = 128

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

    const/16 v0, 0x80
    new-array v0, v0, [Ljava/lang/String;
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;

    const/16 v0, 0x80
    new-array v0, v0, [I
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I

    const/16 v0, 0x20
    new-array v0, v0, [I
    iput-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventCounts:[I

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

# Parse one "YYYY-MM-DD|title|color" line; store at next slot for its day
.method private parseAndStoreLine(Ljava/lang/String;)V
    .locals 8

    if-eqz p1, :_ret
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-nez v0, :_ret

    const-string v0, "\\|"
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0

    array-length v1, v0
    const/4 v2, 0x3
    if-lt v1, v2, :_ret

    const/4 v1, 0x0
    aget-object v1, v0, v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, 0xa
    if-lt v2, v3, :_ret

    const/16 v2, 0x8
    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v1

    :try_d_s
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v1
    :try_d_e
    .catch Ljava/lang/Exception; {:try_d_s .. :try_d_e} :_dfail

    const/4 v2, 0x1
    if-lt v1, v2, :_ret
    const/16 v2, 0x1f
    if-gt v1, v2, :_ret

    # v1 = day (1-31)
    add-int/lit8 v2, v1, -0x1
    # v2 = day idx (0-30)

    iget-object v3, p0, Lcom/doldolcal/CalWidgetFactory;->mEventCounts:[I
    aget v4, v3, v2
    # v4 = current count

    const/4 v5, 0x4
    if-ge v4, v5, :_inc_only

    # idx = v2*4 + v4
    shl-int/lit8 v5, v2, 0x2
    add-int/2addr v5, v4

    const/4 v6, 0x1
    aget-object v6, v0, v6
    iget-object v7, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    aput-object v6, v7, v5

    const/4 v6, 0x2
    aget-object v6, v0, v6
    invoke-direct {p0, v6}, Lcom/doldolcal/CalWidgetFactory;->safeColor(Ljava/lang/String;)I
    move-result v6
    iget-object v7, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    aput v6, v7, v5

    :_inc_only
    add-int/lit8 v4, v4, 0x1
    aput v4, v3, v2

    :_ret
    return-void

    :_dfail
    move-exception v0
    return-void
.end method

.method private loadEvents(II)V
    .locals 11

    # Clear mEventTitles (size 128)
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    const/4 v1, 0x0
    const/16 v2, 0x80
    const/4 v3, 0x0
    :clr_t
    if-ge v1, v2, :clr_t_done
    aput-object v3, v0, v1
    add-int/lit8 v1, v1, 0x1
    goto :clr_t
    :clr_t_done

    # Clear mEventColors (size 128)
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    const/4 v1, 0x0
    :clr_c
    if-ge v1, v2, :clr_c_done
    const/4 v3, 0x0
    aput v3, v0, v1
    add-int/lit8 v1, v1, 0x1
    goto :clr_c
    :clr_c_done

    # Clear mEventCounts (size 32)
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mEventCounts:[I
    const/4 v1, 0x0
    const/16 v2, 0x20
    :clr_n
    if-ge v1, v2, :clr_n_done
    const/4 v3, 0x0
    aput v3, v0, v1
    add-int/lit8 v1, v1, 0x1
    goto :clr_n
    :clr_n_done

    :try_s
    # Build monthKey "YYYY-MM"
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, "-"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    add-int/lit8 v2, p2, 0x1
    const/16 v1, 0xa
    if-ge v2, v1, :mk2
    const-string v1, "0"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :mk2
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0

    iget-object v1, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v2, "widget_prefs"
    const/4 v3, 0x0
    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v1

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

    if-eqz v0, :done
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :done

    const-string v1, "\n"
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0

    array-length v1, v0
    const/4 v2, 0x0

    :lp
    if-ge v2, v1, :done
    aget-object v3, v0, v2
    invoke-direct {p0, v3}, Lcom/doldolcal/CalWidgetFactory;->parseAndStoreLine(Ljava/lang/String;)V
    add-int/lit8 v2, v2, 0x1
    goto :lp

    :done
    :try_e
    .catch Ljava/lang/Exception; {:try_s .. :try_e} :_c

    return-void

    :_c
    move-exception v0
    return-void
.end method

.method public onDataSetChanged()V
    .locals 11

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

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
    if-eqz v0, :_wth
    const v1, -0x1
    goto :_thd
    :_wth
    const v1, 0xff1A1A2E
    :_thd
    iput v1, p0, Lcom/doldolcal/CalWidgetFactory;->mDayColor:I

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;

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

    # Store resolved year/month to fields so getViewAt can build dates
    iput v2, p0, Lcom/doldolcal/CalWidgetFactory;->mYear:I
    iput v3, p0, Lcom/doldolcal/CalWidgetFactory;->mMonth:I

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

    invoke-direct {p0}, Lcom/doldolcal/CalWidgetFactory;->resolveSelectedDate()Ljava/lang/String;
    move-result-object v1
    iput-object v1, p0, Lcom/doldolcal/CalWidgetFactory;->mSelectedDate:Ljava/lang/String;

    const/4 v8, 0x1
    sub-int v8, v8, v5

    const/4 v9, 0x0
    const/4 v10, 0x6
    :wk_loop
    if-ge v9, v10, :wk_done

    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0
    const/4 v5, 0x7
    :dy_loop
    if-ge v1, v5, :dy_done

    if-lez v8, :prev_m
    if-gt v8, v6, :next_m

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    goto :dy_sep

    :prev_m
    const-string v11, "0"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :dy_sep

    :next_m
    const-string v11, "0"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :dy_sep
    const/4 v11, 0x6
    if-ge v1, v11, :no_c
    const-string v11, ","
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :no_c
    add-int/lit8 v8, v8, 0x1
    add-int/lit8 v1, v1, 0x1
    goto :dy_loop

    :dy_done
    const-string v11, "|"
    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v9, v9, 0x1
    goto :wk_loop

    :wk_done
    return-void
.end method

.method public getCount()I
    .locals 1
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mWeeks:Ljava/util/ArrayList;
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I
    move-result v0
    return v0
.end method

# Applies click fill-in + selection border to a day cell
.method private applyCellState(Landroid/widget/RemoteViews;II)V
    .locals 8
    # p1 = RemoteViews, p2 = day (1-31), p3 = col (0..6)

    # cell id = 0x7f060033 + col
    const v0, 0x7f060033
    add-int/2addr v0, p3
    # v0 = cell id

    # Build "YYYY-MM-DD"
    iget v1, p0, Lcom/doldolcal/CalWidgetFactory;->mYear:I
    iget v2, p0, Lcom/doldolcal/CalWidgetFactory;->mMonth:I
    add-int/lit8 v2, v2, 0x1

    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v4, "-"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/16 v4, 0xa
    if-ge v2, v4, :_m2
    const-string v4, "0"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_m2
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v4, "-"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/16 v4, 0xa
    if-ge p2, v4, :_d2
    const-string v4, "0"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_d2
    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    # v3 = date string

    # Fill-in intent
    new-instance v4, Landroid/content/Intent;
    invoke-direct {v4}, Landroid/content/Intent;-><init>()V
    const-string v5, "date"
    invoke-virtual {v4, v5, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "content://com.doldolcal/select/"
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v5
    invoke-virtual {v4, v5}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    invoke-virtual {p1, v0, v4}, Landroid/widget/RemoteViews;->setOnClickFillInIntent(ILandroid/content/Intent;)V

    # Selection border
    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mSelectedDate:Ljava/lang/String;
    const/4 v5, 0x0
    if-eqz v4, :_apply_bg
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-eqz v4, :_apply_bg
    const v5, 0x7f020004

    :_apply_bg
    const-string v4, "setBackgroundResource"
    invoke-virtual {p1, v0, v4, v5}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    return-void
.end method

.method private resolveSelectedDate()Ljava/lang/String;
    .locals 6

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v1, "widget_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "selected_date_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v2, p0, Lcom/doldolcal/CalWidgetFactory;->mWidgetId:I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0

    if-eqz v0, :_r_tod
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :_r_tod
    return-object v0

    :_r_tod
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
    if-ge v2, v5, :_r_m2
    const-string v5, "0"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_r_m2
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, "-"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/16 v5, 0xa
    if-ge v3, v5, :_r_d2
    const-string v5, "0"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_r_d2
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    return-object v4
.end method

# Renders one day's event cells (2 slots max; +N on slot 1 if count > 2)
.method private renderDayEvents(Landroid/widget/RemoteViews;II)V
    .locals 8
    # p1 = RemoteViews, p2 = day (0 = empty), p3 = col (0..6)

    const/4 v0, 0x0
    if-lez p2, :_r_do
    add-int/lit8 v1, p2, -0x1
    iget-object v2, p0, Lcom/doldolcal/CalWidgetFactory;->mEventCounts:[I
    aget v0, v2, v1
    :_r_do
    # v0 = count

    # Slot 0 (evt0_N id = 0x7f060010 + col)
    const v1, 0x7f060010
    add-int/2addr v1, p3

    const/4 v2, 0x1
    if-lt v0, v2, :_s0_clr

    # Real event at slot 0
    add-int/lit8 v3, p2, -0x1
    shl-int/lit8 v3, v3, 0x2
    # v3 = (day-1)*4

    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    aget-object v4, v4, v3
    if-nez v4, :_s0_t
    const-string v4, ""
    :_s0_t
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    aget v5, v4, v3
    const-string v4, "setBackgroundColor"
    invoke-virtual {p1, v1, v4, v5}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V
    const v4, -0x1
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :_s1_do

    :_s0_clr
    const-string v4, ""
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const/4 v4, 0x0
    const-string v5, "setBackgroundColor"
    invoke-virtual {p1, v1, v5, v4}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    :_s1_do
    # Slot 1 (evt1_N id = 0x7f060018 + col)
    const v1, 0x7f060018
    add-int/2addr v1, p3

    const/4 v2, 0x3
    if-ge v0, v2, :_s1_ovfl

    const/4 v2, 0x2
    if-ne v0, v2, :_s1_clr

    # count == 2: real event at slot 1
    add-int/lit8 v3, p2, -0x1
    shl-int/lit8 v3, v3, 0x2
    add-int/lit8 v3, v3, 0x1
    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventTitles:[Ljava/lang/String;
    aget-object v4, v4, v3
    if-nez v4, :_s1_t
    const-string v4, ""
    :_s1_t
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    iget-object v4, p0, Lcom/doldolcal/CalWidgetFactory;->mEventColors:[I
    aget v5, v4, v3
    const-string v4, "setBackgroundColor"
    invoke-virtual {p1, v1, v4, v5}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V
    const v4, -0x1
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextColor(II)V
    goto :_r_end

    :_s1_ovfl
    # count >= 3: "+N" (N = count - 1)
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "+"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    add-int/lit8 v3, v0, -0x1
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {p1, v1, v2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v2, 0xff999999
    invoke-virtual {p1, v1, v2}, Landroid/widget/RemoteViews;->setTextColor(II)V
    const v2, 0x20000000
    const-string v3, "setBackgroundColor"
    invoke-virtual {p1, v1, v3, v2}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V
    goto :_r_end

    :_s1_clr
    const-string v4, ""
    invoke-virtual {p1, v1, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const/4 v4, 0x0
    const-string v5, "setBackgroundColor"
    invoke-virtual {p1, v1, v5, v4}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    :_r_end
    return-void
.end method

.method public getViewAt(I)Landroid/widget/RemoteViews;
    .locals 13

    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0

    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040001
    invoke-direct {v1, v0, v2}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

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
    if-eqz v0, :norm_sz
    const v11, 0x41a80000
    goto :sz_done
    :norm_sz
    const v11, 0x41300000
    :sz_done

    # Multiply by widget scale
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    const-string v2, "widget_prefs"
    const/4 v12, 0x0
    invoke-virtual {v0, v2, v12}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v12, "scale_"
    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v12, p0, Lcom/doldolcal/CalWidgetFactory;->mWidgetId:I
    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const v12, 0x3f800000
    invoke-interface {v0, v2, v12}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v12
    mul-float v11, v11, v12

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
    goto :do_events

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
    if-ne v9, v4, :do_events
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

    :do_events
    invoke-direct {p0, v1, v9, v6}, Lcom/doldolcal/CalWidgetFactory;->renderDayEvents(Landroid/widget/RemoteViews;II)V

    if-lez v9, :after_click
    invoke-direct {p0, v1, v9, v6}, Lcom/doldolcal/CalWidgetFactory;->applyCellState(Landroid/widget/RemoteViews;II)V
    :after_click

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
    .locals 3
    iget-object v0, p0, Lcom/doldolcal/CalWidgetFactory;->mContext:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    new-instance v1, Landroid/widget/RemoteViews;
    const v2, 0x7f040001
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
