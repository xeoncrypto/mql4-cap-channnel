#property copyright "Copyright © 2019, TEST"

#property indicator_chart_window
#property indicator_minimum 0.0
#property indicator_maximum 1.0
#property indicator_buffers 2
#property indicator_color1 DodgerBlue
#property indicator_color2 Red

// 矢印の大きさを指定する
extern int allow_size = 5;
// アラート通知
extern bool alert_notification = TRUE;
bool Gi_92 = FALSE;
double G_ibuf_96[];
double G_ibuf_100[];
int G_datetime_104;

// 初期化
int init() {
   SetIndexStyle(0, DRAW_ARROW, EMPTY, allow_size, DodgerBlue);
   SetIndexBuffer(0, G_ibuf_96);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, allow_size, Red);
   SetIndexBuffer(1, G_ibuf_100);
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234);
   IndicatorShortName("SuperTriggerV1");
   return (0);
}

int deinit() {
   ObjectDelete("time");
   return (0);
}

int start() {
   
   int Li_12;
   int Li_16;
   int Li_20;
   int Li_24;
   int Li_4 = IndicatorCounted();
   if (Li_4 > 0) Li_4--;
   int Li_0 = Bars - Li_4;
   for (int Li_8 = 0; Li_8 < Li_0; Li_8++) {
      G_ibuf_96[Li_8] = EMPTY_VALUE;
      G_ibuf_100[Li_8] = EMPTY_VALUE;
      if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, Li_8) > iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, Li_8) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, Li_8 + 1) < iMA(NULL,
         0, 8, 0, MODE_EMA, PRICE_CLOSE, Li_8 + 1)) {
         if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) > iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8)) G_ibuf_96[Li_8] = Low[Li_8] - iATR(NULL, 0, 8, 0) / 2.0;
      } else {
         if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, Li_8) < iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, Li_8) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, Li_8 + 1) > iMA(NULL,
            0, 8, 0, MODE_EMA, PRICE_CLOSE, Li_8 + 1))
            if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) < iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8)) G_ibuf_100[Li_8] = High[Li_8] + iATR(NULL, 0, 8, 0) / 2.0;
      }
   }
   if (TimeCurrent() - G_datetime_104 != 0) {
      G_datetime_104 = TimeCurrent();
      Li_12 = Time[0] + 60 * Period() - TimeCurrent();
      Li_24 = Li_12 % 60;
      Li_20 = (Li_12 - Li_24) / 60 % 60;
      Li_16 = (Li_12 - Li_24 - 60 * Li_20) / 3600;
      if (Li_12 < 60 && Gi_92 == FALSE) {
         if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 0) > iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, 0) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 1) < iMA(NULL, 0, 8,
            0, MODE_EMA, PRICE_CLOSE, 1)) {
            if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) > iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8))
               if (alert_notification == TRUE) Alert(Symbol(), "  M", Period(), " Buy Ready");
         } else {
            if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 0) < iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, 0) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 1) > iMA(NULL, 0, 8,
               0, MODE_EMA, PRICE_CLOSE, 1)) {
               if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) < iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8))
                  if (alert_notification == TRUE) Alert(Symbol(), "  M", Period(), " Sell Ready");
            }
         }
         Gi_92 = TRUE;
      }
      if (Li_12 >= 60 && Gi_92 == TRUE) {
         if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 1) > iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, 1) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 2) < iMA(NULL, 0, 8,
            0, MODE_EMA, PRICE_CLOSE, 2)) {
            if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) > iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8))
               if (alert_notification == TRUE) Alert(Symbol(), "  M", Period(), " Buy Entry");
         } else {
            if (iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 1) < iMA(NULL, 0, 8, 0, MODE_EMA, PRICE_CLOSE, 1) && iMA(NULL, 0, 4, 0, MODE_EMA, PRICE_CLOSE, 2) > iMA(NULL, 0, 8,
               0, MODE_EMA, PRICE_CLOSE, 2)) {
               if (iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, Li_8) < iMA(NULL, 0, 50, 0, MODE_EMA, PRICE_CLOSE, Li_8))
                  if (alert_notification == TRUE) Alert(Symbol(), "  M", Period(), " Sell Entry");
            }
         }
         Gi_92 = FALSE;
      } else
         if (Li_12 > 60) Gi_92 = FALSE;
   }
   return (0);
}
