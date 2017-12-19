--模拟点击
function myClick(x,y)
  touchDown(1, x, y)  --ID为1的手指在坐标（x,y）处按下
  mSleep(200) --延时200毫秒
  touchUp(1, x, y)
  --showFinger(x,y)		--显示
end
--单消
function c1()
  myClick(1731,977)
end
--触摸位置显示
function showFinger(x,y)
  tips_finger = createHUD()
  showHUD(tips_finger,"◎",40,"0xff00ff00","0x00ff0000",0,x-60,y-60,120,120)
  mSleep(50)
  showHUD(tips_finger,"◎",60,"0xff00ff00","0x00ff0000",0,x-60,y-60,120,120)
  mSleep(50)
  showHUD(tips_finger,"◎",80,"0xff00ff00","0x00ff0000",0,x-60,y-60,120,120)
  mSleep(50)
  hideHUD(tips_finger)
end
--检测开始,返回坐标
function IfStartAtt()
  mSleep(200)
  x, y = findColor({1429, 910, 1715, 1030}, 
    "0|0|0xdeffff,248|2|0x218a9c,104|41|0xffffff,84|45|0x42cfef,139|49|0xffffff,174|44|0x42cfef",
    95, 0, 0, 0)
  if x > -1 then
    myClick(x,y)
    --tips_start = createHUD() 
    --showHUD(tips_start,"点击:开始",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
    sysLog("点击:开始")
  end
  
  return x,y
end
--检测读图,返回坐标
function IfBlack()
  mSleep(200)
  x, y = findColor({30, 813, 666, 1071}, 
    "0|0|0x000000,-2|130|0x000000,184|7|0x000000,174|141|0x000000,308|5|0x000000,318|150|0x000000",
    100, 0, 0, 0)
  if x > -1 then
    --tips_black = createHUD() 
    --showHUD(tips_black,"等待加载...",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
    sysLog("等待加载...")
  end
  return x,y
end
--检测战斗状态,返回坐标
function IfInAtt()
  mSleep(200)
  x, y = findColor({3, 860, 106, 1076}, 
    "0|0|0xad7552,4|-57|0x735542,-27|100|0x422010,3|74|0x734531,-76|-73|0x422021",
    95, 0, 0, 0)
  if x > -1 then
    sysLog("开始战斗")
  end
  return x,y
end


--检测重新挑战,返回布尔值
function IfReStart()
  mSleep(200)
  x, y = findColor({646, 865, 728, 946}, 
    "0|0|0xfffffd,3|1|0x3a7281,19|-16|0x247c90,22|-20|0xfffdf8,25|25|0xf7ffff,25|17|0x42cbef",
    85, 0, 0, 0)
  if x > -1 then
    myClick(x,y)
    --tips_restart = createHUD() 
    --showHUD(tips_restart,"点击:重新挑战",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
    sysLog("点击:重新挑战")
  end
  return x,y
end
--[[
function IfGetHero()
  x, y = findColor({625, 666, 961, 905}, 
    "0|0|0x313521,9|-2|0x524131,209|-8|0x312819,215|-8|0x524131,209|89|0x4aceee",
    95, 0, 0, 0)
  return x,y
end
--]]

--自动战斗
function AutoAtt(i,t)
  sysLog("AutoAtt")
  tips_auto=createHUD()
  --tips_finger = createHUD()
  while 1==1
  do
    x1,y1=IfStartAtt()
    if x1>-1 then
      showHUD(tips_auto,"点击:开始",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
      break
    else
      x2,y2=IfReStart()
      if x2>-1 then
        showHUD(tips_auto,"点击:重新挑战",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
        break
      end
    end
  end
  
  while 1==1
  do
    x3,y3=IfBlack()
    if x3>-1 then
      showHUD(tips_auto,"地图加载中......",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
      break
    end
  end
  
  while 1==1 
  do
    x4,y4=IfInAtt()
    if x4>-1 then
      showHUD(tips_auto,"进入战斗",28,"0xffff0000","0xcc4bbe46",2,0,-0,500,70)
      break
    end
  end
  
  mSleep(500)
  showHUD(tips_auto,"第 "..i.." 次,剩余 "..t-i.." 次",28,"0xffff0000","0xcc4bbe46",3,710,-505,500,70)
  while 1==1
  do
    c1()
    --[[
    xh,yh=IfGetHero()
    if xh>-1 then
      vibrator()
      dialog("获得新的勇士!\n点击确定后继续.")
      for i=5,1,-1 do
        showHUD(tips_auto,i.."秒后继续......",28,"0xffff0000","0xccffffff",3,710,-505,500,70)
        mSleep(1000)
      end
    end
    --]]
    x, y = findColor({646, 865, 728, 946}, 
      "0|0|0xfffffd,3|1|0x3a7281,19|-16|0x247c90,22|-20|0xfffdf8,25|25|0xf7ffff,25|17|0x42cbef",
      85, 0, 0, 0)
    if x > -1 then
      sysLog("restart")
      --hideHUD(tips_finger)
      break
    end
  end
  hideHUD(tips_auto)
  
end

--main入口
init("0", 1)
setScreenScale(1080,1920)
tips = createHUD() 
--延迟3秒
for i=3,1,-1 do
  showHUD(tips,i.."秒后开始执行脚本......",28,"0xffff0000","0xccffffff",3,710,-505,500,70)
  mSleep(1000)
end
hideHUD(tips) 
sysLog("脚本已执行.")
--简单版
--[[
i=1
while 1==1
do
  AutoAtt(i,1000)
  i=i+1
end
--]]

--ui参数版


--dialog参数版

while 1==1
do
  NumTimes = dialogInput("请输入刷本次数\n不限次数直接点\"确认\".","在这里输入次数:","确认")
  mSleep(200)
  
  if NumTimes ~= 0 and NumTimes ~= "" then  --如果均已填写
    --dialog("刷图次数:"..NumTimes.."次\n请点击\"确定\"继续")
    mSleep(1000)
    break
  elseif NumTimes == 0 or NumTimes == "" then
    --dialog("不限次数\n请点击\"确定\"继续.")
    NumTimes=999
    break
  elseif tonumber(NumTimes) == nil then
    dialog("只允许输入数字\n请重输!")
  end
  
end

--tips = createHUD() 
for i=1,tonumber(NumTimes)
do
  sysLog("第 "..i.." 次,剩余 "..tonumber(NumTimes)-i.." 次")
  --showHUD(tips,"刷图第 "..i.." 次,剩余 "..tonumber(NumTimes)-i.." 次",28,"0xffff0000","0xcc4bbe46",3,710,-505,500,70)
  AutoAtt(i,tonumber(NumTimes))
end