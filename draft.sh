#!/bin/bash

# # # read -p "enter an input " input
# # # if [[ $input == +([a-zA-Z0-9_-]) ]] && [[ $input == [a-zA-Z]* ]];then
# # #     echo "valid"
# # # else
# # #     echo "not valid"
# # # fi
# # #--------------------------

# # declare -a data_types


# # the data
# # $ cat data.log
# # [12/Mar/2015] /var/lib/file1.txt
# # [12/Mar/2015] /var/lib/file2.txt
# # [12/Mar/2015] /var/lib/file3.txt

# # # the associative array declaration
# # $ declare -A map

# # # read the data from the file into the array
# # $ while read -r date file; do map[$file]=$date; done < data.log

# # # iterate through the data
# # $ for key in "${!map[@]}"; do printf "%s => %s\n" "$key" "${map[$key]}"; done
# # /var/lib/file3.txt => [12/Mar/2015]
# # /var/lib/file2.txt => [12/Mar/2015]
# # /var/lib/file1.txt => [12/Mar/2015]

# # while read -a -r line;
# # do
# #     #dictionary[$column_name]=$column_datatype
# #     for word in $line; do
# #         columns_name[$i] = $word
# #         i++
# #     done
# # done < ~/Desktop/dic.txt
# declare -a line
# declare -a columns_name

# names=$(awk -F : ' 
# BEGIN {
#     declare -a columns_name
# } 
# {
#    if (NR == 1)
#    {
#     for (i = 1; i <= NF; i++)
#         used[$i] = 1
#    }
# } ' ~/Desktop/dic.txt)

# types=$(awk -F : '  
# {
#    print $2
# } ' ~/Desktop/dic.txt)


# for c in "${names[@]}"
# do
#     echo c[]
# done
# for ((i=0; i<3; i++))
# do
#     echo ${columns_name[$i]} "*"
# # done
# # for key in "${!dictionary[@]}"
# # do
# #     echo $key 
# # done

# # for key in "${!dictionary[@]}"
# # do
# #     echo $key ":" ${dictionary[$key]}
# # done
# #==============================
#     # columns_name=$(awk -F : '  { print $1 } ' /etc/passwd)
#     # data_types=$(awk -F : '  { print $2 } ' /etc/passwd)

#         # awk -F: '
#         # BEGIN {
#         #         declare -a columns_name
#         #         j=1 
#         #         i=0
#         # }
#         # {
           
#         #     while(NR == 1 && j <= NF){
#         #         columns_name[$i]=$j
#         #         j++;
#         #         i++;
#         #     }
#         # } ' /etc/passwd  
    

#     #columns_name=$(awk -F: 'NR == 1 {print $0}' /etc/passwd  )
#     #data_types=$(awk -F: 'NR == 2 {print $0}' /etc/passwd)

#     # for ((i=0; i<10; i++))
#     # do
#     #     echo ${columns_name[$i]} 
#     # done

#     echo "******************"
#     # for ((i=0; i<10; i++))
#     # do
#     #     echo ${data_types[$i]} 
#     # done

#     # for((i=0; i<10; i++))
#     # do
#     #     dictionary[${columns_name[$i]}]=${data_types[$i]} 
#     # done

#     # for key in "${!dictionary[@]}"
#     # do
#     #     echo $key ":" ${dictionary[$key]}
#     # done
# #///////////////////////////////////
# # read -p "enter number of columns" columns_num
# # for ((i=0; i<columns_num; i++))
# # do
# #     read columns_name[$i]
# # done

# # for ((i=0; i<columns_num; i++))
# # do
# #     read data_types[$i]
# # done

# # for((i=0; i<columns_num; i++))
# # do
# #     dictionary[${columns_name[$i]}]=${data_types[$i]} 
# # done


# # for key in "${!dictionary[@]}"
# # do
# #     echo $key ":" ${dictionary[$key]}
# # done

# #///////////////////////////////////
# #************************************
# # animals['key']='value' to set value

# # "${animals[@]}" to expand the values

# # "${!animals[@]}" (notice the !) to expand the keys

# # # key_var='key3'
# # # value_var='value3'
# # # test_dict[$key_var]=$value_var

# # # for key in "${!test_dict[@]}"; do
# # #     echo "$key ${test_dict[$key]}"
# # # done
# #************************************

# a=aaa
# b=($(awk -va="$a" 'BEGIN{for(i=1;i<=3;i++) {printf("%s%d\n", a, i)}}'))
# for x in "${b[@]}"; do echo "$x"; done

# while IFS=: read colName colDatatype colConstraint
# do
#     echo "first='$first' last='$last' varx='$varx'"
#     # do something
# done

# declare -a col_names
# declare -a col_types
# declare -a col_constraints
# declare -A name_type
# declare -A name_constraint

# IFS=$'\n' read -d '' -r -a lines < ~/Desktop/dic.txt
    
#     for i in "${!lines[@]}"
#     do
#         IFS=':' read -r -a column <<< "${lines[i]}"
#         col_names[$i]=${column[0]}
#         col_types[$i]=${column[1]}
#         col_constraints[$i]=${column[2]}
#     done

#     # for((i=0; i<3; i++))
#     # do
#     #     echo ${col_names[$i]} "*"
#     # done

#     for((i=0; i<3; i++))
#     do
#         name_type[${col_names[$i]}]=${col_types[$i]} 
#     done

#     for((i=0; i<3; i++))
#     do
#         name_constraint[${col_names[$i]}]=${col_constraints[$i]} 
#     done

#     for key in "${!name_type[@]}"
#     do
#         echo $key ":" ${name_type[$key]}
#     done

#     echo "***************************"
#     for key in "${!name_constraint[@]}"
#     do
#         echo $key ":" ${col_constraints[$key]}
#     done

# read -p "enter the column name to be updated " column_name
# read -p "the new value for the column" new_column_value
#  awk -F : -v col_index="${name_order[$column_name]}" new_value="$new_column_value"  ' 
# {
#     $col_index=new_value
#     print "inside awk"
# } ' ~/Documents/Bash-DBMS/abdo/tests 