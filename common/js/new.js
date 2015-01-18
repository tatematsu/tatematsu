function newM(y,m,d)
{
newday=new Date(y+"/"+m+"/"+d);
oldday= new Date();
n=(oldday-newday)/(1000*60*60*24);
if (n <=3)document.write("<img src='http://www.la-michelle.com/common/img/sub/top/main_icon_new.gif' />");
}