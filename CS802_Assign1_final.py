
"""
Created on Tue Feb 16 17:06:03 2021

@author: mihalis
"""

import sys
from graphviz import Digraph
import pandas as pd


#-----------#
# STN class #
#-----------#\
INF = 10**7

class STN:

    ## useful maximum upper bound
    inf = sys.float_info.max

    ## list of nodes and adjacency list
    def __init__(self):
        self.node = []
        self.adj_list = {}
    
       
    ## print STN in DOT form
    def print_stn(self):
        dot = Digraph(comment = "Graph")
        ## add nodes
        for i in self.node:
            dot.node(i)
        ## add edges
        for i in self.node:
            for j in self.adj_list[i]:
                if self.adj_list[i][j] != INF and i!=j:
                    dot.edge(i, j, label=str(self.adj_list[i][j]))
        return dot
    #dot.render("test-output/Graph.gv", view=True)
    #dot.render("test", view=True)
 

    ## TODO check the consistency of the STN
    def check_consistency(self):
        
        #print("adj list old", self.adj_list)
        for k in self.node:
            for i in self.node:
                for j in self.node:
                   

                        if (self.adj_list[i][k] != INF) and (self.adj_list[k][j] != INF):
                            self.adj_list[i][j] = min(self.adj_list[i][j], self.adj_list[i][k] + self.adj_list[k][j])
                            if i == j and self.adj_list[i][j] < 0:
                                 return False
        #print("adjlist updated", self.adj_list)
        return True



    ## TODO remove dominated edges from the STN
    def make_minimal(self):
    
        for i in self.node:
            for k in self.node:
                for j in self.node:
                    if i!=j and j!=k and i!=k: 
                         if (i in self.adj_list) and (k in self.adj_list) and (j in self.adj_list):
                      
                            if (j in self.adj_list[i]) and (k in self.adj_list[i]) and (j in self.adj_list[k]):
                                    if self.adj_list[i][j] < 0 and self.adj_list[i][k] < 0:
                                        if self.adj_list[i][k] + self.adj_list[k][j] == self.adj_list[i][j]:
                                            self.adj_list[i].pop(j)
                                            #print("REMOVED j", self.adj_list)
                             
                                    elif self.adj_list[i][j] >= 0 and self.adj_list[k][j] >= 0:
                                        if self.adj_list[i][k] + self.adj_list[k][j] == self.adj_list[i][j]:
                                            self.adj_list[i].pop(j)
                                            #print("REMOVED j", self.adj_list)
        #print("adj_list final", self.adj_list)                        



#open the DOT file
filename = "match_plan_4.dot"
with open(filename, "r") as dotfile:
#
    stn = STN()
    
    for line in dotfile:
        ## read edge
        if "->" in line:
            print(line)
            string1 = line.split()
            weight = float(string1[4][6:].strip('"'))

            if string1[0] not in stn.node:
                stn.node.append(string1[0])
            if string1[2] not in stn.node:
                stn.node.append(string1[2])

            ## TODO set all self distances to 0
            if string1[0] not in stn.adj_list:
                stn.adj_list[string1[0]] = {string1[0]:0}
                
            if string1[2] not in stn.adj_list:
                stn.adj_list[string1[2]] = {string1[2]: 0}
                    
            else:
            
                stn.adj_list[string1[0]][string1[2]] = weight

    ## TODO set missing distances to infinity
    for node in stn.node:
        for node_dest in stn.node:
            if node_dest not in stn.adj_list[node]:
                stn.adj_list[node][node_dest] = INF

# =============================================================================

#print("Node list", stn.node)
#print("Initial Adj List", stn.adj_list)


    ## Check consistency, make minimal, and print!
if stn.check_consistency():
        print("Graph before minimal")
        dot = stn.print_stn()
        print(dot)
        dot
    
        stn.make_minimal()
        print("graph after minimal")
        dot = stn.print_stn()
        print(dot)
        dot
else:
        print("NOT CONSISTENT")



