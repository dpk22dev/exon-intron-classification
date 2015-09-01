>>proj_readfile() 
It reads the file given in function proj_readfile and 
takes strings one by one and give it to proj_process_str() function.
proj_process_str() will put exons and introns present in given string and 
put them in "exon" and "intron" vectors. It will then send each row of "exon"
vector i.e. an exon to proj_process_exon() function & send each row of "intron"
vector i.e. an intron to proj_process_intron() function.
Function proj_process_exon() calculates the interarrival time for each base
A,C,G,T and puts it int exon_A, exon_C, exon_G, exon_T files respectively if
passed parameter "user" to function is 0 and puts them in uexon_A, uexon_C,
uexon_G, uexon_T if passed parameter "user" to function is 1.
Similarly function proj_process_intron() calculates the interarrival time for each base
A,C,G,T and puts it into intron_A, intron_C, intron_G, intron_T files respectively if
passed parameter "user" to function is 0 and puts them in uintron_A, uintron_C,
uintron_G, uintron_T if passed parameter "user" to function is 1.

>>proj_plot()
It reads the exon_A, exon_C, exon_G, exon_T , intron_A, intron_C, intron_G, intron_T
files and plot the graph for each using hold and figure commands of matlab.

>>proj_user_input()
It reads string given by user as "user_input" and sends them to project_process_str().
Don't change "user" variable to zero.If it becomes zero proj_process_str() will not
create exon and intron data files named uexon_A, uexon_C, uexon_G, uexon_T, 
uintron_A, uintron_C, uintron_G, uintron_T.
It will then call proj_test_classifier() which will classfy userinput string into introns 
and exons and find the accuracy for it.
Don't change "user" variable to zero.If it becomes zero proj_test_classofier() will not
test "user_input" and will create testdata set from original data.

