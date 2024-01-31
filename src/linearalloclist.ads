with Ada.Text_IO; use Ada.Text_IO;
with Food_DataStructures; use Food_DataStructures;

package LinearAllocList is

   capacity : Natural := 21;
   subtype slotindex is Natural range 0 .. capacity -1;
    
   type foodarray is array(slotindex) of Food_Pack;
     
   function isFull return Boolean;
   function isEmpty return Boolean;
   
   procedure insert(msg: in Food_Pack);
   procedure retrieve(Target: in Food_Pack; outitem: out Food_Pack);
   
   function BinarySearch(box: in foodarray; Target: in Food_Pack) return slotindex;

end LinearAllocList;
