#!/usr/bin/bash
 
echo "Please choose from the menu below"

function main_menu(){
    select order in CreateDB ConnectDB ListDB DropDB
    do 
        case $order in 
            CreateDB ) 
                DB_Creation 
            ;;
            ConnectDB )
                DB_Connection
            ;;
            ListDB ) 
                DB_Listing
            ;;
            DropDB )
                DB_Drop
            ;;
            * )
                echo "Invalid number, make sure you entered a number from the menu."
        esac
    done

}

function DB_Creation(){
    while true
        do
            read -p "Enter Name of DB :" name

            if [[ $name == +([a-zA-Z0-9_-]) ]] && [[ $name == [a-zA-Z]* ]];then 
                if [ -e $name ];then 
                    echo "already existed"
                else
                    echo "correct name"
                    mkdir ./$name
                    break
                fi 
            else
                echo "error in naming database please, re-enter a proper name" 

            fi
        done
}

function DB_Connection(){
            while true
                do
                read -p "Enter Name of DB " name 
                if [[ $name == +([a-zA-Z0-9_-]) ]] && [[ $name == [a-zA-Z]* ]];then
                    if [ -d $name ] ; then 
                        cd ./$name
                        echo "you're at " `pwd`
                        list_DBConnection_functions
                        break
                    
                    else 
                        echo "Sorry it's not existed please, check if this database is existed  "
                        break
                    fi

                else
                        echo " error in database name please, re-enter it"
                        #continue
                fi
                done
}



function DB_Listing(){
        ls -F | grep "/" | sed 's/\///g'
}

function DB_Drop(){
    while true
        do
            read -p "Enter Name of DB  to:" name
            if [[ $name == +([a-zA-Z0-9_-]) ]] && [[ $name == [a-zA-Z]* ]];then 
                if [ -e $name ];then 
                    rm -r ./$name
                    echo "the database was removed"
                    break
                else
                    echo "Sorry, no database with this name or it's already deleted."
                    break
                fi 
            else
                echo "error in naming database please, re-enter a proper name" 
                #continue
            fi
        done
} 

function list_DBConnection_functions(){
    select i in "List tables" "Create tables" "Drop tables" "Insert tables" "Select from table" "Update table" "Delete from table" "Exit database"
    do 
       case $i in
        "List tables" )
            source ../list_tables.sh
        ;;
        "Create tables" )
            source ../create_table.sh
        ;;
        "Drop tables" )
            source ../delete_table.sh
        ;;
        "Insert tables" )
            source ../insert_into_table.sh
        ;;
        "Select from table" )
            source ../select_from.sh
        ;;
        "Update table" )
            source ../update_table.sh
        ;;
        "Delete from table" )
            source ../delete_from.sh
        ;;
        "Exit database" )
            cd ..
            echo "you're at " `pwd`
            main_menu
        ;;
        * )
        
       esac 
    done 
}
#------------------------------------------

main_menu

export -f list_DBConnection_functions