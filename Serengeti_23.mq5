//+------------------------------------------------------------------+
//|                                            Spike Cath Pro 23.mq5 |
//|                                         Copyright 2022, TzFxLab. |
//|                                           https://t.me/Tz_Fx_Lab |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Tz Fx Logics."
#property link      "https://t.me/Tz_Fx_Lab"
#property version   "22.02"
#property indicator_chart_window
#property indicator_buffers 18
#property indicator_plots 5

//User descriptions
#property description "Eagle Edition"
#property description "Trade All Boom & Crash Pairs the focused way!"
#property description "Contact us:"
#property description "\nEmail: mnfungo@gmail.com "
#property description "you are welcome"
#property copyright "Click HERE to visit our telegram page"

//---INDICATOR QUICK SETTINGS
input string IndicatorQuickSettings; //SYSTEM QUICK SETTINGS
input int LithoValue = 3; //Litho Period

//---THEME SETTINGS
//input string ThemeSettings; //Theme Settings
enum ThemeModes
  {
   BlackMode = 1, //Indoor Mode
   ColorMode = 2  //Outdoor Mode
  };
input ThemeModes SelectedThemeMode = 1; //Applied Theme Format

//plotting secuence
input string plotables;      //PLOTABLES (INDICATORS Plot)
input bool autoplot = true;  //Auto Indicator Plot
input bool PlotPointer = true; //Plot Pointer

//---CUBITIES
enum Container
  {
   Container1 = 1,  //Container 1 (Mxc,Mxd,Mxe, oxc & Omxd)
   Container2 = 2, //Container 2 (Pmx)
   Container3 = 3, //Container 3 (Regular)
   Container4 = 4, //Container 4 (SigSpikes& Md_Spikes)
   Container5 = 5,  //Container 5 (BaseSpikes, Conv_Spikes && SnC_CrossSpikes)
  };
input Container SelectedContainer = 1; //Selected Container:

//First container programming
input string Containers1; //FIRST CONTAINER STRATEGIES
input bool Mxc_Spikes = true; //Mxc_Spikes
input bool Mxd_Spikes = true; //Mxd_Spikes
input bool Mxe_Spikes = true; //Mxe_Spikes
input bool Omx_Spikes = true; //Omx_Spikes
input bool Oxc_Retracement = true; //Oxc_Retracement (AT)
input bool Omxd_PullBack = true; //Omxd_PullBack (AT)
input bool C50n200_Cross = true; //C50n200_Cross (AT)

//Second container programmming
input string Containers2; //SECOND CONTAINER STRATEGIES
input bool Pmx_Spikes = true;      //Pmx_Spikes
input bool pmx_warsSpikes = true;   //pmx_warsSpikes

//Third container programming
input string Containers3; //THIRD CONTAINER STRATEGIES
input bool RegularSpikes = true;      //RegularSpikes

//Forth container programmings
input string Containers4;    //FORTH CONTAINER STRATEGIES
input bool DP_Spikes = true; //DP_Spikes
input bool CP_Spikes = true; //CP_Spikes
input bool EP_Spikes = true; //EP_Spikes
input bool PW_Spikes = true; //PW_Spikes
input bool Nomx_Spikes = true; //Nomx_Spikes
input bool DW_Spikes = true; //DW_Spikes
input bool Sig_Spikes = true; //Sig_Spikes
input bool BC_PullBack = true; //BC_PullBack

//Fifth container programmings
input string Containers5; //FIFTH CONTAINER STRATEGIES
input bool Base_Spikes = true;      //Base_Spikes
input bool Conv_Spikes = true;      //Conv_Spikes
input bool SnC_CrossSpikes = true;  //SnC_CrossSpikes
input bool IB_Spikes = true;         //IB_Spikes
input bool Pre_IBSpikes = true;   //Pre_IBSpikes
input bool LithoSystem = true;     //LithoSystem(3)

//Other parameters
int MaxPeriod = 200;
int UpRSI = 70;
int DnRSI = 30;

//---NOTIFICATION SETTINGS
input string NotificationCenter;           //NOTIFICATION SETTINGS
input bool WindowsAlert = true;            //Get Windows Alert
input bool PushNotification = true;        //Get Push Notification
input bool SoundNotification = true;       //Get Sound Notification

//--- ARROW PLOTTING SEQUENCE
//Buy arrow
#property indicator_type1 DRAW_ARROW      //Draws a Arrow on chart
#property  indicator_label1 "Buy Arrow"   //indicates the lable when hovered over on chart
#property  indicator_color1 clrDodgerBlue //Specifies our plotting color
#property indicator_style1 STYLE_SOLID    //draws a solid line on chart
#property  indicator_width1  2           //Sets the indicator width

//Sell Arrow
#property  indicator_type2 DRAW_ARROW     //Draws a Arrow on chart
#property  indicator_label2 "Sell Arrow"  //Indicates the lable when hovered over on chart
#property  indicator_color2 clrRed        //Specifies our plotting color
#property  indicator_style2 STYLE_SOLID  //Draws a solid line on chart
#property  indicator_width2  2           //Sets the indicator width

//--- MOVING AVERAGES PLOTTING SEQUENCE
//Max moving average
#property  indicator_type3 DRAW_LINE      //Draws a line on chart
#property  indicator_label3 "Max"         //Indicates the lable when hovered over on chart
#property  indicator_color3 clrMagenta      //Specifies our plotting color
#property  indicator_style3 STYLE_SOLID   //Draws a solid line on chart
#property  indicator_width3 2             //Sets the indicator width

//Slow moving average
#property  indicator_type4 DRAW_LINE      //Draws a line on chart
#property  indicator_label4 "Slow"         //Indicates the lable when hovered over on chart
#property  indicator_color4 clrRed //Specifies our plotting color
#property  indicator_style4 STYLE_SOLID   //Draws a solid line on chart
#property  indicator_width4 2             //Sets the indicator width

//Fast moving average
#property  indicator_type5 DRAW_LINE      //Draws a line on chart
#property  indicator_label5 "Fast"         //Indicates the lable when hovered over on chart
#property  indicator_color5 clrDodgerBlue //Specifies our plotting color
#property  indicator_style5 STYLE_SOLID   //Draws a solid line on chart
#property  indicator_width5 2             //Sets the indicator width

//--- INDICATOR BUFFERS
//Arrow buffers
double ArrowBuy[];
double ArrowSell[];

//Moving average
double Max[];
double Slow[];
double Fast[];

//Bands
double UpperBand[];
double LowerBand[];
double MiddleBand[];

//Oscilators
double rsi[];
double ControlLine[];
double Histogram[];
double Signal[];
double mema[];
double Litho[];
double orsi[];
double pmx[];
double regular[];
double Pointer[];


//--- INDICATOR HANDLES
//Lines Handles
//--- handles for moving averages
int MaxHandle;
int SlowHandle;
int FastHandle;
int BollingerHandle;
int RsiHandle;
int OrsiHandle;
int ControlLineHandle;
int MacdHandle;
int MemaHandle;
int LithoHandle;
int regularHandle;
int pmxHandle;
int PointerHandle;

//deiniit assitor
bool checked;

//Arrow Characters
#define  UpArrow   233
#define  DownArrow 234
#define  ArrowShift 45


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//---- indicator buffer settings
//BUY  ARROW
   SetIndexBuffer(0, ArrowBuy, INDICATOR_CALCULATIONS);
   PlotIndexSetInteger(0, PLOT_DRAW_BEGIN, MaxPeriod);
   PlotIndexSetInteger(0, PLOT_ARROW, UpArrow);
   PlotIndexSetInteger(0, PLOT_ARROW_SHIFT, ArrowShift);

//SELL  ARROW
   SetIndexBuffer(1, ArrowSell, INDICATOR_CALCULATIONS);
   PlotIndexSetInteger(1, PLOT_DRAW_BEGIN, MaxPeriod);
   PlotIndexSetInteger(1, PLOT_ARROW, DownArrow);
   PlotIndexSetInteger(1, PLOT_ARROW_SHIFT, -ArrowShift);

//MAX MA
   SetIndexBuffer(2, Max, INDICATOR_CALCULATIONS);
   PlotIndexSetInteger(2, PLOT_DRAW_BEGIN, MaxPeriod);

//Slow MA
   SetIndexBuffer(3, Slow, INDICATOR_CALCULATIONS);
   PlotIndexSetInteger(3, PLOT_DRAW_BEGIN, MaxPeriod);

//Fast MA
   SetIndexBuffer(4, Fast, INDICATOR_CALCULATIONS);
   PlotIndexSetInteger(4, PLOT_DRAW_BEGIN, MaxPeriod);

//RSI BUFFER
   SetIndexBuffer(5, rsi, INDICATOR_CALCULATIONS);

//ControLine Buffer
   SetIndexBuffer(6, ControlLine, INDICATOR_CALCULATIONS);

//MiddleBandl BUFFER
   SetIndexBuffer(7, MiddleBand, INDICATOR_CALCULATIONS);

//UpperBAnd BUFFER
   SetIndexBuffer(8, UpperBand, INDICATOR_CALCULATIONS);

//LowerBand BUFFER
   SetIndexBuffer(9, LowerBand, INDICATOR_CALCULATIONS);

//Histogram BUFFER
   SetIndexBuffer(10, Histogram, INDICATOR_CALCULATIONS);

//Signal BUFFER
   SetIndexBuffer(11, Signal, INDICATOR_CALCULATIONS);

//mema BUFFER
   SetIndexBuffer(12, mema, INDICATOR_CALCULATIONS);
//Litho BUFFER
   SetIndexBuffer(13, Litho, INDICATOR_CALCULATIONS);

//pmx BUFFER
   SetIndexBuffer(14, pmx, INDICATOR_CALCULATIONS);

//Regular BUFFER
   SetIndexBuffer(15, regular, INDICATOR_CALCULATIONS);
//Regular BUFFER
   SetIndexBuffer(16, orsi, INDICATOR_CALCULATIONS);

//Regular BUFFER
   SetIndexBuffer(17, Pointer, INDICATOR_CALCULATIONS);


//--- GET INDICATOR HANDLES
//line handles
   MaxHandle = iMA(_Symbol, 0, 200, 0, MODE_SMA, PRICE_CLOSE);
   SlowHandle = iMA(_Symbol, 0, 50, 0, MODE_EMA, PRICE_CLOSE);
   FastHandle = iMA(_Symbol, 0, 20, 0, MODE_SMA, PRICE_CLOSE);
   OrsiHandle = iRSI(_Symbol, 0, 2, PRICE_CLOSE);
   regularHandle = iRSI(_Symbol, 0, 6, PRICE_CLOSE);
   pmxHandle = iRSI(_Symbol, 0, 13, PRICE_CLOSE);
   RsiHandle = iRSI(_Symbol, 0, 13, PRICE_CLOSE);
   ControlLineHandle = iMA(_Symbol, 0, 7, 0, MODE_SMA, RsiHandle);
   BollingerHandle = iBands(_Symbol, 0, 34, 0, 1.619, RsiHandle);

//--- Second window drawings
   MacdHandle = iMACD(_Symbol, 0, 12, 26, 9, PRICE_CLOSE);
   MemaHandle = iMA(_Symbol, 0, 200, 0, MODE_SMA, MacdHandle);
   LithoHandle = iRSI(_Symbol, 0, LithoValue, MacdHandle);


   PointerHandle = iMA(_Symbol, 0, 6, 0, MODE_SMA, PRICE_CLOSE);
//--- THEME SETTINGS AND SELECTION MODULES
   if(SelectedThemeMode == 1)
     {
      ChartSetInteger(0, CHART_FOREGROUND, false); //enabled candles to be under indicactors
      ChartSetInteger(0, CHART_SCALE, 3); //Candle width
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, true); //Show Ask line
      ChartSetInteger(0, CHART_SHOW_BID_LINE, true); //Show Bid line
      ChartSetInteger(0, CHART_SHOW_LAST_LINE, true); //Show Bid line
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrBlack); //background color
      ChartSetInteger(0, CHART_COLOR_CHART_UP, clrLime); //Up candle color
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrLime); //Up candle color
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrRed); //low candle color
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrRed); //low candle color
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrWhite); //foreground color
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrLime); //ChartLine color
      ChartSetInteger(0, CHART_COLOR_GRID, clrLightSlateGray); // Choose back color for grid lines
      ChartSetInteger(0, CHART_SHOW_GRID, false); //do not show the grid
      ChartSetInteger(0, CHART_COLOR_BID, clrLightSlateGray);
      ChartSetInteger(0, CHART_COLOR_ASK, clrRed);
      ChartSetInteger(0, CHART_COLOR_LAST, C'0,192,0');
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrRed);
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, false); //Dont Shiw period separator
     }


//Outdor Mode
   if(SelectedThemeMode == 2)
     {
      //Default theme settings
      ChartSetInteger(0, CHART_FOREGROUND, false); //enabled candles to be under indicactors
      ChartSetInteger(0, CHART_SCALE, 5); //Candle width
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, true); //Show Ask line
      ChartSetInteger(0, CHART_SHOW_BID_LINE, true); //Show Bid line
      ChartSetInteger(0, CHART_SHOW_LAST_LINE, true); //Show Bid line
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrWhite); //background color
      ChartSetInteger(0, CHART_COLOR_CHART_UP, C'38,166,154'); //Up candle color
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, C'38,166,154'); //Up candle color
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, C'239,83,80'); //Low candle color
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, C'239,83,80'); //Low candle color
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrBlack); //foreground color
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, C'86,186,132'); //ChartLine color
      ChartSetInteger(0, CHART_COLOR_GRID, C'241,236,242'); // Choose back color for grid lines
      ChartSetInteger(0, CHART_SHOW_GRID, false); //do not show the grid
      ChartSetInteger(0, CHART_COLOR_BID, C'38,166,154');
      ChartSetInteger(0, CHART_COLOR_ASK, C'239,83,80');
      ChartSetInteger(0, CHART_COLOR_LAST, C'156,186,240');
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, C'239,83,80');
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, false); //Dont Shiw period separator
     }
// End of Custom Theme
   if(PlotPointer)
     {
      ChartIndicatorAdd(0, 0, PointerHandle);
     }
//-- Indicator plotting function/automatic indicator ploting
   if(autoplot)
     {
      //--- Automatic plotting for container 1
      if(SelectedContainer == 1)
        {
         if(ChartIndicatorsTotal(0, 1) < 2)
           {
            ChartIndicatorAdd(0, 1, MacdHandle);
            ChartIndicatorAdd(0, 1, OrsiHandle);
           }
        }


      //--- Automatic plotting for container 2
      if(SelectedContainer == 2)
        {
         if(ChartIndicatorsTotal(0, 1) < 2)
           {
            ChartIndicatorAdd(0, 1, MacdHandle);
            ChartIndicatorAdd(0, 1, pmxHandle);
           }
        }


      //--- Automatic plotting for container 3
      if(SelectedContainer == 3)
        {
         if(ChartIndicatorsTotal(0, 1) < 2)
           {
            ChartIndicatorAdd(0, 1, MacdHandle);
            ChartIndicatorAdd(0, 1, regularHandle);
           }
        }


      //--- Automatic plotting for container 4
      if(SelectedContainer == 4)
        {
         if(ChartIndicatorsTotal(0, 1) < 1)
           {
            ChartIndicatorAdd(0, 1, MacdHandle);
           }
        }


      //--- Automatic plotting for container 5
      if(SelectedContainer == 5)
        {
         if(ChartIndicatorsTotal(0, 1) < 3)
           {
            ChartIndicatorAdd(0, 1, MacdHandle);
            ChartIndicatorAdd(0, 1, ControlLineHandle);
            ChartIndicatorAdd(0, 1, BollingerHandle);
           }
        }

     }



//--- End of onInit function
   return(INIT_SUCCEEDED);
  }




//+------------------------------------------------------------------+
//|Deinitialization function                                         |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(reason == REASON_PARAMETERS ||
      reason == REASON_RECOMPILE  ||
      reason == REASON_ACCOUNT)
     {
      checked = false;
     }
//--- delete the indicator
#ifdef __MQL5__
   int total = (int)ChartGetInteger(0, CHART_WINDOWS_TOTAL);
   for(int subwin = total - 1; subwin >= 0; subwin--)
     {
      int amount = ChartIndicatorsTotal(0, subwin);
      for(int i = amount - 1; i >= 0; i--)
        {
         string name = ChartIndicatorName(0, subwin, i);
         if(StringFind(name, "MACD", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
         if(StringFind(name, "RSI", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
         if(StringFind(name, "SAR", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
         if(StringFind(name, "CCI", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
         if(StringFind(name, "MA", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
         if(StringFind(name, "ATR", 0) == 0)
           {
            ChartIndicatorDelete(0, subwin, name);
           }
        }
     }
   Comment(""); //Dellete all comments on chart, on removing the indicator
#endif
  }




//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---Verificaiton process
//*******************************************************************************
//Tanzania trade logic Signal sending section
//*******************************************************************************
//--- Alert frequency control system
   MqlRates priceData[]; // create price array
   ArraySetAsSeries(priceData, true); //sort the array from current candle downwards
   CopyRates(_Symbol, _Period, 0, 4, priceData); //copy candle prices for 3 candles into array
   static datetime timeStampLastCheck;  //Create Date time variable for the last time Stamp
   datetime timeStampCurrentCandle;  //Create datetime variable for current candle
   timeStampCurrentCandle = priceData[0].time;  //read time stamp for current candle in array


//--- STAMPS
//signal time
   datetime SignalTime = TimeLocal();
//Code to determine trade targets automatically
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);


//--- IS STOPPED FLAG
   if(IsStopped())
      return(0);  //Must respect the stop flag
   if(rates_total < MaxPeriod)
      return(0);   //check that we have enough bars to calculate



//--- CHECK IF HANDLES ARE LOADED CORRECTLY
   if(BarsCalculated(MaxHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(SlowHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(FastHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(RsiHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(ControlLineHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(BollingerHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(MacdHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(MemaHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(LithoHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(OrsiHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(regularHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(pmxHandle) < rates_total)
      return(0);  //not calculated
   if(BarsCalculated(PointerHandle) < rates_total)
      return(0);  //not calculated

//--- COPYING INDICATOR DATA
   int copyBars = 0;  //copying new bars
   int startBar = 0;   //this line copy data for gap creation purpose.
   if(prev_calculated > rates_total || prev_calculated <= 0)
     {
      copyBars = rates_total;
      startBar = MaxPeriod; //this line for handling gaps
     }
   else
     {
      copyBars = rates_total - prev_calculated;
      if(prev_calculated > 0)
         copyBars++;
      startBar = prev_calculated - 1; //This line for handling gaps
     }
//error checking.
   if(IsStopped())
      return(0);   //respect the stop flag



//--- COPYING INDICATOR DATA INTO BUFFERS
//line data
   if(CopyBuffer(MaxHandle, 0, 0, copyBars, Max) <= 0)
      return(0);
   if(CopyBuffer(SlowHandle, 0, 0, copyBars, Slow) <= 0)
      return(0);
   if(CopyBuffer(FastHandle, 0, 0, copyBars, Fast) <= 0)
      return(0);
   if(CopyBuffer(RsiHandle, 0, 0, copyBars, rsi) <= 0)
      return(0);
   if(CopyBuffer(ControlLineHandle, 0, 0, copyBars, ControlLine) <= 0)
      return(0);
   if(CopyBuffer(BollingerHandle, 0, 0, copyBars, MiddleBand) <= 0)
      return(0);
   if(CopyBuffer(BollingerHandle, 1, 0, copyBars, UpperBand) <= 0)
      return(0);
   if(CopyBuffer(BollingerHandle, 2, 0, copyBars, LowerBand) <= 0)
      return(0);
   if(CopyBuffer(MacdHandle, 0, 0, copyBars, Histogram) <= 0)
      return(0);
   if(CopyBuffer(MacdHandle, 1, 0, copyBars, Signal) <= 0)
      return(0);
   if(CopyBuffer(MemaHandle, 0, 0, copyBars, mema) <= 0)
      return(0);
   if(CopyBuffer(LithoHandle, 0, 0, copyBars, Litho) <= 0)
      return(0);
   if(CopyBuffer(OrsiHandle, 0, 0, copyBars, orsi) <= 0)
      return(0);
   if(CopyBuffer(regularHandle, 0, 0, copyBars, regular) <= 0)
      return(0);
   if(CopyBuffer(pmxHandle, 0, 0, copyBars, pmx) <= 0)
      return(0);
   if(CopyBuffer(PointerHandle, 0, 0, copyBars, Pointer) <= 0)
      return(0);


//--- CODE TO GET ARROW PRINTED
//Error checking.
   if(IsStopped())
      return(0);   //respect the stop flag
//Loop for determining where to place the predetermined arrow
   for(int i = startBar; i < rates_total && !IsStopped(); i++)
     {



      //--- Arrow findinng and strategies codes
      ArrowBuy[i] = EMPTY_VALUE; //lines added to control the arrows
      ArrowSell[i] = EMPTY_VALUE;
      if(i > 0)
        {


         //-- the first container for mx related strategies
         if(SelectedContainer == 1)
           {

            //+++++++++++++++++
            //1. Mxc_Spikes
            //+++++++++++++++++
            if(Mxc_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Max[i - 1] < Slow[i - 1] //MaxMa is below SlowMa
                     && Slow[i - 1] < Fast[i - 1] //SlowMa is below FastMa
                     && (mema[i - 1] > 0 || Histogram[i - 1] > Signal[i - 1])
                     && Histogram[i - 1] < 0 //Macd histogram is negative
                     && rsi[i - 2] > DnRSI //Rsi at index 2 is above rsi LowLevel
                     && rsi[i - 1] < DnRSI //si at index 1 is below rsi LowLevel
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Mxc_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Mxc_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Max[i - 1] > Slow[i - 1] //MaxMa is above SlowMa
                     && Slow[i - 1] > Fast[i - 1] //SlowMa is above FastMa
                     && Histogram[i - 1] > 0 //Macd histogram is positive
                     && orsi[i - 2] < UpRSI //rsi at index 2 is below UpperRsiLevel
                     && orsi[i - 1] > UpRSI //rsi at index 1 is above UpperRsiLevel
                     && (mema[i - 1] < 0 || Signal[i - 1] > Histogram[i - 1])
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Mxc_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Mxc_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Mxc_Spikes





            //+++++++++++++++++
            //2. Mxd_Spikes
            //+++++++++++++++++
            if(Mxd_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Slow[i - 1] > Fast[i - 1] //FastMa is below SlowMa
                     && Fast[i - 1] > Max[i - 1] //Fast is above MaxMa
                     && Histogram[i - 1] < 0 //Macd histogram is negative
                     && (Signal[i - 1] < Histogram[i - 1]  || //Macd signal is below Macd histogram
                         mema[i - 1] > 0)
                     && orsi[i - 2] > DnRSI //Rsi at index 2 is above rsi LowLevel
                     && orsi[i - 1] < DnRSI //si at index 1 is below rsi LowLevel
                     && Max[i - 1] > Max[i - 2] //MaxMa is inclined Upwards
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Mxd_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Mxd_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Max[i - 1] > Fast[i - 1] //MaxMa is above FastMa
                     && Fast[i - 1] > Slow[i - 1] //SlowMa is above FastMa
                     && Histogram[i - 1] > 0 //Macd histogram is positive
                     && (Signal[i - 1] > Histogram[i - 1] || //Macd signal line is above macd histogram
                         mema[i - 1] < 0)
                     && orsi[i - 2] < UpRSI //rsi at index 2 is below UpperRsiLevel
                     && orsi[i - 1] > UpRSI //rsi at index 1 is above UpperRsiLevel
                     && Max[i - 1] < Max[i - 2] //MaxMa is inclined downwards
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Mxd_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Mxd_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Mxd_Spikes







            //+++++++++++++++++
            //3. Mxe_Spikes
            //+++++++++++++++++
            if(Mxe_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Slow[i - 1] > Max[i - 1] //Slow is above mac for buy
                     && Fast[i - 1] < Max[i - 1] //Fast line is below Max for (Extreme)
                     && Histogram[i - 1] < 0 //macd histogram is below zero line
                     && Signal[i - 1] < Histogram[i - 1] //Signal line is below the histogram
                     && orsi[i - 1] < DnRSI //rsi have crossed to the down
                     && orsi[i - 2] > DnRSI //before rsi was above the dn level
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Mxe_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Mxe_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Slow[i - 1] < Max[i - 1] //Slow is above mac for buy
                     && Fast[i - 1] > Max[i - 1] //Fast line is below Max for (Extreme)
                     && Histogram[i - 1] > 0 //macd histogram is below zero line
                     && Signal[i - 1] > Histogram[i - 1] //Signal line is below the histogram
                     && orsi[i - 1] > UpRSI //rsi have crossed to the down
                     && orsi[i - 2] < UpRSI //before rsi was above the dn level
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Mxe_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Mxe_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Mxe_Spikes




            //+++++++++++++++++
            //4. Omx_Spikes
            //+++++++++++++++++
            if(Omx_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Max[i - 1] > Fast[i - 1] //Slow Moving average is above fast
                     && Histogram[i - 1] < 0 //macd histogram is negative
                     && Signal[i - 1] < Histogram[i - 1] //Macd signal is below macd histogram
                     && orsi[i - 2] > DnRSI //cci at index 2 is above low line
                     && orsi[i - 1] < DnRSI //cci at index 1 is below low line
                     && Fast[i - 1] > Fast[i - 2] //Fast moving average is Sloping upwards
                     && open[i - 1] > Fast[i - 1] //Prices have Opened above Fast Moving average
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Omx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Omx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1] //20 sma is above 200 sma
                     && Histogram[i - 1] > 0 // macd histogram is positive
                     && Signal[i - 1] > Histogram[i - 1] //Macd signal is above macd histogram
                     && orsi[i - 2] < UpRSI //cci at index 2 is below up line
                     && orsi[i - 1] > UpRSI //cci at index 1 is above up line
                     && Fast[i - 1] < Fast[i - 2] //Fast moving average is Sloping down
                     && close[i - 1] < Fast[i - 1] //Prices have closed below Fast Moving average
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Omx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Omx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Omx_Spikes












            //+++++++++++++++++
            //5. Oxc_Retracement
            //+++++++++++++++++
            if(Oxc_Retracement)
              {
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Slow[i - 1] //FastMa is above SlowMa
                     && Slow[i - 1] > Max[i - 1] //SlowMa is above MaxMa
                     && Histogram[i - 1] > 0 //Macd histogram is Positive
                     && orsi[i - 2] > DnRSI //Rsi at index 2 is Above LowerRsiLevel
                     && orsi[i - 1] < DnRSI //Rsi at index 1 is below LowerRsiLevel
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Oxc_Retracement" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Oxc_Retracement " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Max[i - 1] > Slow[i - 1] //MaxMa is above SlowMa
                     && Slow[i - 1] > Fast[i - 1] //SlowMa is above FastMa
                     && Histogram[i - 1] < 0 //Macd histogram is negative
                     && orsi[i - 2] < UpRSI //Rsi at index 2 is below UpperRsiLevel
                     && orsi[i - 1] > UpRSI //Rsi at index 1 is above UpperRsiLeve
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Oxc_Retracement" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Oxc_Retracement " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Oxc_Retracement









            //+++++++++++++++++
            //5. Omxd_PullBack
            //+++++++++++++++++
            if(Omxd_PullBack)
              {
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Max[i - 1] < Fast[i - 1] //Max is Below Fast
                     && Fast[i - 1] < Slow[i - 1] //Fast is Below Slow (D)
                     && Histogram[i - 1] < 0 //Macd histogram is negative
                     && orsi[i - 2] > DnRSI //Rsi at index 2 is below DnRsiLevel
                     && orsi[i - 1] < DnRSI //Rsi at index 1 is above DnRsiLevel
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Omxd_PullBack" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Omxd_PullBack " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Max[i - 1] > Fast[i - 1] //Max is above Fast
                     && Fast[i - 1] > Slow[i - 1] //Fast is above Slow (D)
                     && Histogram[i - 1] > 0 //Macd histogram is negative
                     && orsi[i - 2] < UpRSI //Rsi at index 2 is below UpperRsiLevel
                     && orsi[i - 1] > UpRSI //Rsi at index 1 is above UpperRsiLeve
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Omxd_PullBack" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Omxd_PullBack " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Omxd_PullBack






            //+++++++++++++++++
            //6. C50n200_Cross
            //+++++++++++++++++
            if(C50n200_Cross)
              {
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Slow[i - 2] < Max[i - 2] //Max is above Fast
                     && Fast[i - 2] > Max [i - 2 ] //Fast is above Slow (D)
                     && Slow[i - 1] > Max[i - 1] //Max is above Fast
                     && Fast[i - 1] > Max [i - 1 ] //Fast is above Slow (D)
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":C50n200_Cross" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":C50n200_Cross " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Slow[i - 2] > Max[i - 2] //Max is above Fast
                     && Fast[i - 2] < Max [i - 2 ] //Fast is above Slow (D)
                     && Slow[i - 1] < Max[i - 1] //Max is above Fast
                     && Fast[i - 1] < Max [i - 1 ] //Fast is above Slow (D)
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":C50n200_Cross" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":C50n200_Cross " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of C50n200_Cross





           }  //End of Container 1


















         //***********    PMX CONTAINER  *********************************
         //**********************************************
         //********************************************
         //*******************************************************
         //********************************************
         //**********************************************
         //*****************************************************
         //*******************************************************
         //**************************************************************
         //****************************************************************
         //***********************************************************************
         //****************************************************************
         //*****************************************************
         //*******************************************************
         //**************************************************************
         //*************************************************************************
         //***********************************************************************
         //*************************************************************************

         //Container no 5  (Pmxcontainer)
         if(SelectedContainer == 2)
           {

            //+++++++++++++++++
            //1. Pmx_Spikes
            //+++++++++++++++++
            if(Pmx_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1] //Fast above max
                     && Histogram[i - 1] < 0  //histos are negative
                     && pmx[i - 1] < DnRSI && pmx[i - 2] > DnRSI //coversion os rsi line
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Pmx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Pmx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1] //Fast under max
                     && Histogram[i - 1] > 0  //histos are positive
                     && pmx[i - 1] > UpRSI && pmx[i - 2] < UpRSI //coversion os rsi line
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Pmx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Pmx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Pmx_Spikes





            //+++++++++++++++++
            //2.pmx_warsSpikes
            //+++++++++++++++++
            if(pmx_warsSpikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1] //Fast above max
                     && Histogram[i - 1] > 0  //histos are positive
                     && pmx[i - 1] < UpRSI && pmx[i - 2] > UpRSI //coversion os rsi line
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":pmx_warsSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":pmx_warsSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1] //Fast under max
                     && Histogram[i - 1] < 0  //histos are positive
                     && pmx[i - 1] > DnRSI && pmx[i - 2] < DnRSI //coversion os rsi line
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":pmx_warsSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":pmx_warsSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of pmx_warsSpikes





           }  //End of Pmx Container 2









         //***********    REGULAR CONTAINER  *********************************||
         //*******************************************************************||
         //*******************************************************************||
         //Container no 3  (Regular container)
         if(SelectedContainer == 3)
           {

            //+++++++++++++++++
            //1. RegularSpikes
            //+++++++++++++++++
            if(RegularSpikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Slow[i - 1] //Fast above max
                     && Slow[i - 1] > Max[i - 1] //Finished C_Arrangement
                     && Histogram[i - 1] > 0  //histos are postitive
                     && regular[i - 1] < DnRSI && regular[i - 2] > DnRSI //coversion os rsi line
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":RegularSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":RegularSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Slow[i - 1] //Fast above max
                     && Slow[i - 1] < Max[i - 1] //Finished C_Arrangement
                     && Histogram[i - 1] < 0  //histos are postitive
                     && regular[i - 1] > UpRSI && regular[i - 2] < UpRSI //coversion os rsi line
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":RegularSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":RegularSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of RegularSpikes


           }  //End of RegularSpikes














         //***********       MACD CONTAINER  *********************************||
         //*******************************************************************||
         //*******************************************************************||
         //Container no 4  (Regular container)
         if(SelectedContainer == 4)
           {

            //+++++++++++++++++
            //1. DP_Spikes
            //+++++++++++++++++
            if(DP_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Slow[i - 1] > Fast[i - 1]  //slow is above fast
                     && Fast[i - 1] > Max[i - 1]  // fast is above max
                     && close[i - 1] - open[i - 1] < 0 //the candle is bearish
                     && Pointer[i - 1] > Fast[i - 1] //pointer is above fast
                     && Pointer[i - 2] < Fast[i - 2]  //pointer was below fast
                     && Histogram[i - 1] < 0  //Histogram is less than zero
                     && Signal[i - 1] < Histogram[i - 1] //coversion os rsi line
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":DP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":DP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Slow[i - 1] < Fast[i - 1]  //Slow is less than fast
                     && Fast[i - 1] < Max[i - 1]  //fast is less than max
                     && close[i - 1] - open[i - 1] > 0 //the candle is bullish
                     && Pointer[i - 1] < Fast[i - 1] //poiner is less than fast
                     && Pointer[i - 2] > Fast[i - 2]  //pointer is above fast
                     && Histogram[i - 1] > 0  //Histogram is above zero
                     && Signal[i - 1] > Histogram[i - 1]  //Signal is above histogram
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":DP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":DP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of DP_Spikes



            //+++++++++++++++++
            //2. CP_Spikes
            //+++++++++++++++++
            if(CP_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Slow[i - 1]
                     && Slow[i - 1] > Max[i - 1]
                     && Pointer[i - 1] > Fast[i - 1]
                     && Pointer[i - 2] < Fast[i - 2]
                     && Histogram[i - 1] < 0
                     && Signal[i - 1] < Histogram[i - 1] //coversion os rsi line
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":CP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":CP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Slow[i - 1]
                     && Slow[i - 1] < Max[i - 1]
                     && Pointer[i - 1] < Fast[i - 1]
                     && Pointer[i - 2] > Fast[i - 2]
                     && Histogram[i - 1] > 0
                     && Signal[i - 1] > Histogram[i - 1]
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":CP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":CP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of CP_Spikes




            //+++++++++++++++++
            //3. EP_Spikes
            //+++++++++++++++++
            if(EP_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Slow[i - 1] > Max[i - 1]
                     && Fast[i - 1] < Max[i - 1] //Found extreme point

                     //Pointer Positioning
                     && Pointer[i - 1] > Fast[i - 1] //Pointer crossed Fast Upwards
                     && Pointer[i - 2] < Fast[i - 2] //Pointer was below Fast

                     //The State of Macd
                     && Histogram[i - 1] < 0 //Histogram at index 1 is less than zero
                     && Histogram[i - 1] > Signal[i - 1] //Signal is below Histogram
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":EP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":EP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Slow[i - 1] < Max[i - 1]
                     && Fast[i - 1] > Max[i - 1] //Found extreme point

                     //Pointer Positioning
                     && Pointer[i - 1] < Fast[i - 1] //Pointer crossed Fast Downwards
                     && Pointer[i - 2] > Fast[i - 2] //Pointer was Above Fast

                     //The State of Macd
                     && Histogram[i - 1] > 0 //Histogram at index 1 is greater than zero
                     && Histogram[i - 1] < Signal[i - 1] //Signal is Above Histogram
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":EP_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":EP_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of EP_Spikes






            //+++++++++++++++++
            //4. PWS_Spikes
            //+++++++++++++++++
            if(PW_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Fast[i - 1] > Slow[i - 1]
                     && Slow[i - 1] > Max[i - 1] //Found continuous point

                     //Pointer Positioning
                     && Pointer[i - 1] < Fast[i - 1] //Pointer crossed Fast Downwards
                     && Pointer[i - 2] > Fast[i - 2] //Pointer was Above Fast (war done)
                     && Fast[i - 1] > Fast[i - 2] //Fast Line is rising upwards

                     //The State of Macd
                     && Histogram[i - 1] > 0 //Histogram at index 1 is greater than zero
                     && Histogram[i - 1] < Signal[i - 1] //Signal is above Histogram
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":PW_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":PW_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Fast[i - 1] < Slow[i - 1]
                     && Slow[i - 1] < Max[i - 1] //Found continuous point

                     //Pointer Positioning
                     && Pointer[i - 1] > Fast[i - 1] //Pointer crossed Fast Upwards
                     && Pointer[i - 2] < Fast[i - 2] //Pointer was below Fast (war done)
                     && Fast[i - 1] < Fast[i - 2] //Fast Line is falling Down

                     //The State of Macd
                     && Histogram[i - 1] < 0 //Histogram at index 1 is less than zero
                     && Histogram[i - 1] > Signal[i - 1] //Signal is below Histogram
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":PW_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":PW_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of PW_Spikes






            //+++++++++++++++++
            //5. Nomx_Spikes
            //+++++++++++++++++
            if(Nomx_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Fast[i - 1] < Slow[i - 1]
                     && Slow[i - 1] < Max[i - 1] //Found continuous point
                     //Fast moving average is inclined upward
                     //&& Fast[i-1]>Fast[i-2]   //fast inclined upwards

                     //Pointer Positioning
                     && Pointer[i - 1] > Fast[i - 1] //Pointer crossed Fast Upwards
                     && Pointer[i - 2] < Fast[i - 2] //Pointer was below Fast

                     //The State of Macd
                     && Histogram[i - 1] < 0 //Histogram at index 1 is less than zero
                     && Histogram[i - 1] > Signal[i - 1] //Signal is below Histogram
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Nomx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Nomx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Fast[i - 1] > Slow[i - 1]
                     && Slow[i - 1] > Max[i - 1] //Found continuous point

                     //Pointer Positioning
                     && Pointer[i - 1] < Fast[i - 1] //Pointer crossed Fast downwars
                     && Pointer[i - 2] > Fast[i - 2] //Pointer was above Fast

                     //The State of Macd
                     && Histogram[i - 1] > 0 //Histogram at index 1 is greater than zero
                     && Histogram[i - 1] < Signal[i - 1] //Signal is above Histogram
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Nomx_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Nomx_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Nomx_Spikes







            //+++++++++++++++++
            //6. DW_Spikes
            //+++++++++++++++++
            if(DW_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Slow[i - 1] > Fast[i - 1]
                     && Fast[i - 1] > Max[i - 1] //Found continuous point

                     //Pointer Positioning
                     && Pointer[i - 1] < Slow[i - 1] //Pointer crossed Slow Downwards
                     && Pointer[i - 2] > Slow[i - 2] //Pointer was above Slow

                     //The State of Macd
                     && Histogram[i - 1] < 0 //Histogram at index 1 is less than zero
                     && Histogram[i - 1] > Signal[i - 1] //Signal is below Histogram
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":DW_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":DW_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     //Main moving averages
                     Slow[i - 1] < Fast[i - 1]
                     && Fast[i - 1] < Max[i - 1] //Found continuous point

                     //Pointer Positioning
                     && Pointer[i - 1] > Slow[i - 1] //Pointer crossed Slow Downwards
                     && Pointer[i - 2] < Slow[i - 2] //Pointer was above Slow

                     //The State of Macd
                     && Histogram[i - 1] > 0 //Histogram at index 1 is less than zero
                     && Histogram[i - 1] < Signal[i - 1] //Signal is below Histogram
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":DW_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":DW_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of DW_Spikes








            //+++++++++++++++++
            //7. Sig_Spikes
            //+++++++++++++++++
            if(Sig_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Slow[i - 1]
                     && Slow[i - 1] > Max[i - 1] //C mode

                     && Histogram[i - 1] < 0
                     && Signal[i - 1] < 0
                     && Signal[i - 2] > 0
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Sig_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Sig_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Slow[i - 1]
                     && Slow[i - 1] < Max[i - 1] //C mode

                     && Histogram[i - 1] > 0
                     && Signal[i - 1] > 0
                     && Signal[i - 2] < 0
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Sig_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Sig_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Sig_Spikes










            //+++++++++++++++++
            //8. BC_PullBack(AT)
            //+++++++++++++++++
            if(BC_PullBack)
              {
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                    Max[i-1]<Slow[i-1]
                     && Histogram[i-1]>0
                     && Histogram[i-2]<0
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":BC_PullBack" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":BC_PullBack " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Max[i-1]>Slow[i-1]
                     && Histogram[i-1]<0
                     && Histogram[i-2]>0
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":BC_PullBack" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":BC_PullBack " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of BC_PullBack




           }  //End of Macd container # 4













         //**************TDI BASED SPIKE FINDING METHODS *************||
         //***********************************************************||
         //***********************************************************||

         //Container no 5  (TDI Spike system)
         if(SelectedContainer == 5)
           {

            //+++++++++++++++++
            //1. BorderSpikes
            //+++++++++++++++++
            if(Base_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1]
                     && ControlLine[i - 1] < DnRSI && ControlLine[i - 2] > DnRSI
                     && UpperBand[i - 1] > UpRSI
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":BorderSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":BorderSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1]
                     && ControlLine[i - 1] > UpRSI && ControlLine[i - 2] < UpRSI
                     && LowerBand[i - 1] < DnRSI
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":BorderSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":BorderSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of BorderSpikes









            //+++++++++++++++++
            //2. Conv_Spikes
            //+++++++++++++++++
            if(Conv_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1]  //Fast is above max
                     // && UpperBand[i-1]<UpRSI

                     //Convergence finder
                     && ControlLine[i - 1] > ControlLine[i - 2] //control line slops upwards
                     && rsi[i - 1] < rsi[i - 2] //rsi slops downwards
                     && rsi[i - 3] < rsi[i - 2] //to cut of arrows repeatition
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Conv_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Conv_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1]  //Fast is below max
                     //&& UpperBand[i-1]<UpRSI

                     //Convergence finder
                     && ControlLine[i - 1] < ControlLine[i - 2] //control line slops downwards
                     && rsi[i - 1] > rsi[i - 2] //rsi slops upwards
                     && rsi[i - 3] > rsi[i - 2] //to cut of arrows repeatition
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Conv_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Conv_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of Conv_Spikes







            //+++++++++++++++++
            //3. SnC_CrossSpikes
            //+++++++++++++++++
            if(SnC_CrossSpikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1]  //Fast is above max
                     // && UpperBand[i-1]<UpRSI

                     //Cross finder
                     && ControlLine[i - 1] > ControlLine[i - 2] //control line slops upwards
                     && rsi[i - 2] > ControlLine[i - 2] //rsi above control
                     && rsi[i - 1] < ControlLine[i - 2] //rsi below control
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":SnC_CrossSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":SnC_CrossSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1]  //Fast is below max
                     //&& UpperBand[i-1]<UpRSI

                     //Cross finder
                     && ControlLine[i - 1] < ControlLine[i - 2] //control line slops downwards
                     && rsi[i - 2] < ControlLine[i - 2] //rsi below control
                     && rsi[i - 1] > ControlLine[i - 2] //rsi above control
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":SnC_CrossSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":SnC_CrossSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of SnC_CrossSpikes






            //+++++++++++++++++
            //4. IB_Spikes
            //+++++++++++++++++
            if(IB_Spikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1]  //Fast is above max
                     //Entry finder
                     && ControlLine[i - 1] < DnRSI
                     && ControlLine[i - 2] > DnRSI
                     //other entried
                     && Histogram[i - 1] < 0
                     //&& mema[i - 1] > 0
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":IB_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":IB_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1]  //Fast is Below max
                     //Entry finder
                     && ControlLine[i - 1] > UpRSI //
                     && ControlLine[i - 2] < UpRSI
                     //other entried
                     && Histogram[i - 1] > 0
                     //&& mema[i - 1] < 0
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":IB_Spikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":IB_Spikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of IB_Spikes







            //+++++++++++++++++
            //5. Pre_IBSpikes
            //+++++++++++++++++
            if(Pre_IBSpikes)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Fast[i - 1] > Max[i - 1]  //Fast is above max
                     //Entry finder
                     && rsi[i - 1] < DnRSI
                     && rsi[i - 2] > DnRSI
                     //other entried
                     && Histogram[i - 1] < 0
                     //&& mema[i - 1] > 0
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":Pre_IBSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":Pre_IBSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Fast[i - 1] < Max[i - 1]  //Fast is Below max
                     //Entry finder
                     && rsi[i - 1] > UpRSI //
                     && rsi[i - 2] < UpRSI
                     //other entried
                     && Histogram[i - 1] > 0
                     //&& mema[i - 1] < 0
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":Pre_IBSpikes" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":Pre_IBSpikes " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of IB_Spikes








            //+++++++++++++++++
            //5. LithoSystem
            //+++++++++++++++++
            if(LithoSystem)
              {
               if(ChartSymbol(0) == "Boom 300 Index" || ChartSymbol(0) == "Boom 500 Index" || ChartSymbol(0) == "Boom 1000 Index")
                 {
                  if(
                     Litho[i - 1] < 0.1
                     && Litho[i - 2] > 0.1
                  )
                    {
                     ArrowBuy[i] = low[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "BUY : " + _Symbol + ":LithoSystem" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "BUY : " + _Symbol + ":LithoSystem " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Ask, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }



               //================
               //Sell Code Here
               //=================
               if(ChartSymbol(0) == "Crash 300 Index" || ChartSymbol(0) == "Crash 500 Index" || ChartSymbol(0) == "Crash 1000 Index")
                 {
                  if(
                     Litho[i - 1] > 99.9
                     && Litho[i - 2] < 99.9
                  )
                    {
                     ArrowSell[i] = high[i];
                     if(timeStampCurrentCandle != timeStampLastCheck)
                       {
                        timeStampLastCheck = timeStampCurrentCandle;
                        if(
                           PushNotification
                        )
                          {
                           SendNotification(
                              "SELL : " + _Symbol + ":LithoSystem" +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "

                           );
                          }
                        if(
                           WindowsAlert)
                          {
                           Alert(
                              "SELL : " + _Symbol + ":LithoSystem " +
                              "\nTime Frame :" + StringSubstr(EnumToString((ENUM_TIMEFRAMES)_Period), 7) +
                              "\nEntry Price :" + DoubleToString(Bid, _Digits) +
                              "\nTime :" + TimeToString(SignalTime) +
                              "\nVisit: " + "https://t.me/Tz_Fx_Lab "
                           );
                          }
                        if(SoundNotification)
                          {
                           PlaySound("wait.wav");
                          }
                       }
                    }
                 }
              }  //End of LithoSystem











           }  //End of EAGLE Cubit














         //End multstrategy selector loop.
         //+----------------------------------------------+
        }



     }


//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
