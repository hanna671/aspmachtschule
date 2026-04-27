staff(hanna;emma). 
room(a110,4).

% everyone needs to be assigned to exactly one room
1{allocation(Person,Room):room(Room,_)}1 :- staff(Person).

teacher(anna,german).
