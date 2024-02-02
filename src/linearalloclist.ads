with Ada.Text_IO; use Ada.Text_IO;
with Food_DataStructures; use Food_DataStructures;
generic
   type message is private;
   with function GetFoodType(msg: in message) return Food_Type is <>;
package linearalloclist is
    capacity: Natural := 21;
    subtype slotindex is Natural range 0 .. capacity - 1;
    procedure insert(msg: in message);
    procedure remove(msg: out message);
    function get(targetFoodType : Food_Type) return slotindex;
    function isFull return Boolean;
    function isEmpty return Boolean;
end linearalloclist;
