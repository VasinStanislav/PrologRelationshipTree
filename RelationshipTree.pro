DOMAINS
	sisters = string*
PREDICATES
	%To define these:
	nondeterm Male(string)
  	nondeterm Female(string)
  	
	nondeterm Parent(string, string)
	nondeterm Married(string, string)
	
	%Not to forget to implement these:
	nondeterm Brother_in_law(string, string)
	nondeterm Father_in_law(string, string)
	nondeterm Sister_in_law(string, string)
	nondeterm Granddaughter(string, string)  
	nondeterm Brother(string, string)
	/*------------------------------------*/
	nondeterm Grandson(string, string)
	nondeterm Do_have_same_parent(string, string)
	nondeterm Get_sisters(string, string)
	nondeterm Get_length(sisters, integer)
	nondeterm Does_has_more_than_1_sis(string)
CLAUSES
	%Definition:
	Male("Ivan").
	Male("Oleg").
	Male("Victor").
	Female("Anna").
	Female("Nina").
	Female("Vera").
	Female("Alla").
	Female("Larisa").
	Female("Natalia").

	Parent("Ivan", "Nina").
	Parent("Ivan", "Oleg").
	Parent("Anna", "Nina").
	Parent("Anna", "Oleg").
	Parent("Oleg", "Alla").
	Parent("Oleg", "Larisa").
	Parent("Vera", "Alla").
	Parent("Vera", "Larisa").
	Parent("Larisa", "Natalia").
	Parent("Victor", "Natalia").
	
	Married("Ivan", "Anna").
	Married("Oleg", "Vera").
	Married("Victor", "Larisa").
	
	%Implementation:
	Brother_in_law(Brother1, Sister1) :- 
		Married(Husband, Sister1), Parent(Parent1, Brother1), Parent(Parent1, Sister1), Male(Brother1), Female(Sister1).
	
	Father_in_law(Father, Daughter) :- 
		Parent(Father, Daughter), Married(Husband, Daughter), Male(Father), Female(Daughter).
		
	Sister_in_law(Sister1, Brother1) :- 
		Married(Brother1, Wife), Parent(Parent1, Brother1), Parent(Parent1, Sister1), Male(Brother1), Female(Sister1).
		
	Granddaughter(Granddaughter1, GrannyOrGrandpa) :- 
		 Parent(Parent1, Granddaughter1), Parent(GrannyOrGrandpa, Parent1), Female(Granddaughter1).
		 
	Brother(Brother1, Sister1) :- 
		Parent(Parent1, Brother1), Parent(Parent1, Sister1), Male(Brother1), Female(Sister1).
	
	/* ------------------------------------------ */	
	Grandson(Grandson1, GrannyOrGrandpa) :- 
		 Parent(Parent1, Grandson1), Parent(GrannyOrGrandpa, Parent1), Male(Grandson1).
		 
	Do_have_same_parent(Child1, Child2) :- 
		Parent(Who, Child1), Parent(Who, Child2).
		
	Get_sisters(Child1, Who) :- 
		Parent(Father, Child1), Parent(Father, Who), not(Who = Child1), Male(Father), Female(Who).
		
	Get_length([], 0).
	
	Get_length([_|T], L) :- 
		Get_length(T, T_length), L = T_length + 1.
		
	Does_has_more_than_1_sis(Child1) :- 
		findall(Who, Get_sisters(Child1, Who), Sisters), Get_length(Sisters, L), L > 1.
			
GOAL
%	Parent("Ivan", "Alla").
%	Parent(Who, "Larisa").
%	Parent("Oleg", Who).	
%	Granddaughter("Natalia", Who).
%	Parent(Parent1, Child1).
%	Do_have_same_parent("Oleg", "Nina").
%	Granddaughter(Who, "Anna"); Grandson(Who2, "Anna").
%	Parent(Parent1, "Larisa"), Parent(Parent1, Who), not(Who = "Larisa"), Male(Parent1), Female(Who).
%	Get_sisters("Larisa", Who).
%	findall(Who, Get_sisters("Larisa", Who), Sisters), Get_length(Sisters, L), L > 1.
	Does_has_more_than_1_sis("Larisa").
	
		