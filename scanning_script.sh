#!/bin/bash

ListNamespaces=$(kubectl get namespaces -o name)
echo "NameSpace :${ListNamespaces}"
nextscan=0
#Read the particular namespace name for getting all pods inside it.
while [ $nextscan -ne 1 ]
do
    read -p "Enter the user namespace: " nameSpace
    echo "Current namespace: $nameSpace"

    #Read the namespace and show all pods related to particular namespace.
    ListPod=$(kubectl get pods -n $nameSpace -o name)
    echo "Name of the Pod: ${ListPod}"
    echo "Enter the Pod name for scanning "
    
    for podName in $ListPod
    do  
        podName=`echo $podName | cut -d '/' -f 2`
        echo "Scanning pod: $podName"
        Output=$(kubectl logs $podName)
        echo "Output  : ${Output}">"$nameSpace"-"$podName"$(date +"%d-%m-%Y-%T").txt
    done

    echo Number: $i
    nextscan=1
    echo "Do you want to scan again yes or no"  
    read temporary
    if [ $temporary = 'yes' ]; then
    nextscan=0
    fi
done


