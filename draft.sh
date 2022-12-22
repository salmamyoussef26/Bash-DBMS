# #!/bin/bash

# # read -p "enter an input " input
# # if [[ $input == +([a-zA-Z0-9_-]) ]] && [[ $input == [a-zA-Z]* ]];then
# #     echo "valid"
# # else
# #     echo "not valid"
# # fi
# #--------------------------
declare -A dictionary
# declare -a columns_name
# declare -a data_types


# the data
# $ cat data.log
# [12/Mar/2015] /var/lib/file1.txt
# [12/Mar/2015] /var/lib/file2.txt
# [12/Mar/2015] /var/lib/file3.txt

# # the associative array declaration
# $ declare -A map

# # read the data from the file into the array
# $ while read -r date file; do map[$file]=$date; done < data.log

# # iterate through the data
# $ for key in "${!map[@]}"; do printf "%s => %s\n" "$key" "${map[$key]}"; done
# /var/lib/file3.txt => [12/Mar/2015]
# /var/lib/file2.txt => [12/Mar/2015]
# /var/lib/file1.txt => [12/Mar/2015]

while read -r column_name column_datatype;
do
    dictionary[$column_name]=$column_datatype
done < /etc/passwd

for key in "${!dictionary[@]}"
do
    echo $key ":" ${dictionary[$key]}
done

# for key in "${!dictionary[@]}"
# do
#     echo $key ":" ${dictionary[$key]}
# done
#==============================
    # columns_name=$(awk -F : '  { print $1 } ' /etc/passwd)
    # data_types=$(awk -F : '  { print $2 } ' /etc/passwd)

        # awk -F: '
        # BEGIN {
        #         declare -a columns_name
        #         j=1 
        #         i=0
        # }
        # {
           
        #     while(NR == 1 && j <= NF){
        #         columns_name[$i]=$j
        #         j++;
        #         i++;
        #     }
        # } ' /etc/passwd  
    

    #columns_name=$(awk -F: 'NR == 1 {print $0}' /etc/passwd  )
    #data_types=$(awk -F: 'NR == 2 {print $0}' /etc/passwd)

    # for ((i=0; i<10; i++))
    # do
    #     echo ${columns_name[$i]} 
    # done

    echo "******************"
    # for ((i=0; i<10; i++))
    # do
    #     echo ${data_types[$i]} 
    # done

    # for((i=0; i<10; i++))
    # do
    #     dictionary[${columns_name[$i]}]=${data_types[$i]} 
    # done

    # for key in "${!dictionary[@]}"
    # do
    #     echo $key ":" ${dictionary[$key]}
    # done
#///////////////////////////////////
# read -p "enter number of columns" columns_num
# for ((i=0; i<columns_num; i++))
# do
#     read columns_name[$i]
# done

# for ((i=0; i<columns_num; i++))
# do
#     read data_types[$i]
# done

# for((i=0; i<columns_num; i++))
# do
#     dictionary[${columns_name[$i]}]=${data_types[$i]} 
# done


# for key in "${!dictionary[@]}"
# do
#     echo $key ":" ${dictionary[$key]}
# done

#///////////////////////////////////
#************************************
# animals['key']='value' to set value

# "${animals[@]}" to expand the values

# "${!animals[@]}" (notice the !) to expand the keys

# # key_var='key3'
# # value_var='value3'
# # test_dict[$key_var]=$value_var

# # for key in "${!test_dict[@]}"; do
# #     echo "$key ${test_dict[$key]}"
# # done
#************************************


