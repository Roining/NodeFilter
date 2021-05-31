
Node Filter is a knowledge management tool  which relies on the concepts of transclusion and hierarchical filtering to connect different pieces of information  and place them in a transitive hierarchy of abstractions.
 
 User input  is organized in a tree structure in which each node can contain arbitrary text and any node  can be copied to any place in the hierarchy. Cloned nodes mirror each other's descendants.  


# Filtering  
Hierarchical filtering shows the descendants(or ascendants) of a certain node. However, if a node is copied, then if at least one instance of the node matches the filter(i.e. is a descendant of  a queried node), then all its other instances will also match the filter(if using >> and << operators). There are several types of hierarchical filters(see query syntax).  
Hierarchical filtering can   be  used to build a  hierarchy(or multiple linked hierarchies) of abstractions  of arbitrary depth that can be used as a transitive tagging system. A hierarchy of abstractions can be defined by the user. 	 Hierarchies can be built going from specific things up to abstract concepts.   
Hierarchical filtering can be used to emulate the bi-directional linking functionality, and  to extend it to support different user-defined types of bi-directional links.  

# Query syntax:  
There are several types of filters.  
1.Hierarchical filters:  
\>:*id of node X* -  shows  only  direct descendants of node X.The filter matches if any node in the knowledge base is  either Node X or it's descendants.
 Example:  
\>:*id of node X*&&r:[7-9]  
 Result:  
 Descendants of node X which contain numbers from 7 to 9  

\>>:*id of node X*  - shows transclusive descendants(copied descendants) of node X and of it's copied nodes. The filter matches if any node in the knowledge base is the same node  or  is a copied node of  either Node X or it's descendants.
Example:  
\>>:*id of node X*&&>>:*id of node Y*&&NOT&&>>:*id of node Z*&&query    
Result:  
Transclusive descendants of both node X and node Y but not node Z which contain "query"  

\>>>:*id of node X* - shows only direct transclusive descendants.The filter matches if any node in the knowledge base is the same node  or  is a copied node of  either Node X or it's descendants.   
\>^::*id of node X* - matches any node Y if node Y or any ascendant of node Y is a node X or a copy of node X.  
\<:*id of node X* - shows all ascendants of node X up to the root node.  
\<<:*id of node X* -  shows transclusive ascendants of node X.I.e.  if node X or any ascendant of node X is a copy of a any node Y, then node Y matches this filter.  
2.Regex filter: r:*regex expression*     
All nodes that match the regex expression are shown.  
3.Default string filter(without any prefix): *any number of words separated by space*  
Node X matches the filter if node X or any ascendant of node X contains one of the words in queried words 
4.Sorting queries:  
In a tree structure, only sibling nodes are compared to each other when the tree is sorted.  
The soritng method is desinged to emulate a table functionality. Nodes are sorted by the "value" of their child node(child nodes play the role of properties, "value" of the property is just the first child node of this property ).

4.1. sortNAsc:*id of a node X* - the nodes which have node X as descendant are sorted numerically by the value of the first child of node X in ascending order.  
4.2. sortNDesc:*id of a node X* - the nodes which have node X as descendant are sorted numerically by the value of the first child of node X in descending order.  
4.3. sortAAsc:*id of a node X* - the nodes which have node X as descendant are sorted alphabetically by the value of the first child of node X in ascending order.  
4.4. sortADesc:*id of a node X* - the nodes which have node X as descendant are sorted alphabetically by the value of the first child of node X in descending order.  

Example: Template node  "Priority" is copied as a child of two sibling nodes - node Z and node Y.Insert a child node for each created  "Priority" node (there are two new ones now, descending from node z and node Y).Set the values,for example, as 12 and 9 respectively.  
In this case, sortNAsc:*id of a Priority node* will put node Y over node Z, since the 9 is less than 12 and the order is ascending.  
sortNDesc:*id of a Priority node* will  put Node Z over node X.  
Notes:  
1.If node X matches the filter, then all of node X ascendants up to the root node will be shown in the tree   
2.Multiple filters can be combined into one query(separated by "&&").  
Example:  
\>:*id of node X*&&WordA    
Result:  
 Descendants of node X which contain string  "WordA" are shown  
3.Template nodes are marked green, copied nodes are marked blue.  
4.Filters can be negated by the use of NOT operator or softened by the use of OR operator.    
Example of a negated query:   
a) NOT&&WordB    
Result:  
Nodes which don't contain WordB will be shown  
b) WordA&&NOT&&WordB    
Result:Nodes which contain WordA but don't contain WordB will be shown  
OR operator will match if node X matches the following part of query and will not match if  node X  matches none of the parts of query following the operator   
Example of softened query:  
OR&&>:*id of node X*&&OR&&>:*id of node Y*   
Result:  
Show  descendants   of  node X and node Y  
5. >  and >> operators can specify how many levels of descendants will match the filter. For example, >1:*id of node X* will only match node X and >2:*id of node X* will match the children of node X as well. By default, these operators will match all descendants.  
6. Order of queries in a combined query matters. By default, each next query filters the results of the previous.  

# Navigation  
Node Filter is currently navigated only through keyboard shortcuts(see the full list of shortcuts below).  
Any number of tabs and windows can be created(Ctrl-T and Ctrl-K shortcuts respectively).  
Workflow for filtering:  
For hierarchical filtering, the id of the selected node is needed(press Ctrl-E to copy  the id of the selected node to the clipboard and Ctrl-V to paste the id to the search box).  
Example of id:  {741211e4-141c-424c-a80d-35ffa423ea58}  
Example of hierarchical query:    
\>>: {741211e4-141c-424c-a80d-35ffa423ea58}  
To move nodes, copy the node(Ctrl-Q) and insert it at its destination(Ctrl-M or Ctrl-Shift-M).  
To see children of node X, expand node X(Ctrl-G).      
To search for a node, create a new tab/window and use any type of filter, like the default hierarchical string search or regex search. It's also possible to query the current tab and then to go back to the previous query.  
To zoom into node X, filter the data to show descendants of node X(example of query:  >:*id of node X*). Alternatively, use Ctrl-O shortcut.   
To go to the previous query in the current tab, Ctrl-z the query in the search box and Ctrl-Y to go to the next query.    


## Full list of shortcuts relevant to navigation:  
Ctrl-G - expand/hide(toggle) the selected node  
Ctrl-Shift-G - incrementally expand descendant nodes of the selected node  
Ctrl-F - move focus to the search box of  the current tab  
Escape key (when focus is on the search box) - move focus from the search box back to node hierarchy  
Ctrl-Shift-Q - move the keyboard focus to the tab on the left  
Ctrl-Shift-E - move the keyboard focus to the tab on the right  
Ctrl-T - open new tab  
Ctrl-W - close current tab  
Ctrl-K - open new window  
Ctrl-Shift-W - save current session and exit  
Ctrl-Shift-U  - discard current session and exit  
Ctrl-O - zoom into the selected node  

## Node manipulation shortcuts  
Ctrl-Shift-N - insert new node as a child of the selected node.  
Ctrl-N - iinsert new node as a sibling of the selected node  
Ctrl-Q - copy the selected node.  
Ctrl-M - insert the copied node as a sibling of the selected node  
Ctrl-Shift-M - insert the copied node as a child of the selected node  
Ctrl-D - delete the selected node and all  it's descendants  
Ctrl-E - copy the id of the selected node to the clipboard (Ctrl-V to insert the id in the search box)
Ctrl-P - mark the selected node as a template(or as a "blocking node"). Template nodes don't "mirror" the children of their copied nodes. By default, if a some node is inserted as a child of  a  node copied from node X, then node X will copy the inserted node. Template node disable this behaviour for the selected node  
Ctrl-Shift-P -remove the template mark from the selected node  
Ctrl-S - save the changes manually  


# Use cases  
## Transitive filtering  
Example:  
 Create a node  to take notes on a certain topic.For example, let's call the node "History of Geography". Insert all notes on history of Geography as children(or descendants) of the created node.   
Then create a node "Later" to dump all notes (for example,book/article/etc) that you want to revisit later. 
To "tag" a note as "Later", copy the node that contains to note(Ctrl-Q) and insert it as child of "Later"(Ctrl-Shift-M)  
To find all nodes that descend from "Later", you need to get the id of the node(select it and press Ctrl-E) and use hierarchical filter:   
\>>:*id of node "Later"*  
This filter will search for all nodes that descend from "Later" and their copies. Since the nodes that were inserted as children of "Later"  also descend from   "History of Geography" , they will match the filter and will be shown in the resulting filtered view  
Create  a node called "Important", insert it as a child of "Later" and copy all nodes  you consider important as a child of "Important".  
Now, if you insert any node as a child  of "Important", they will also match when searching for descendants of "Later"(the query above) because the filtering is transitive.  

## Bi-directional links and concept maps  
Example of creating dependencies between tasks.  
Create  nodes "Task A" and "Task B" (you may create them  near each other as children of some node or  in entirely  different parts of the knowledge base ).  
Create a "depends on" node and mark it as a template node(Ctrl-P).  
Insert a "depends on" template node as a child of "Task A", then copy "Task B" as a child of "depends on" node.  
Now, while seeing  on which tasks "Task A" depends on is trivial since they are shown as descendents of "Task A", to find out which tasks are dependent on "Task B" we need to search for ascendants of both nodes:  
\<<:*id of "Task B"*&&<<:*id of "depends on"*    
Alternatively, we can use  \>^ operator:  
\>^:*id of "Task B"*&&>^:*id of "depends on"*    

If we use "depends on" in context of concept mapping, then we may categorize it as a linking word.If we want to know all of Task B's links to other nodes, then we need to create "linking words" node,copy "depends on" as a child of it  and search for ascendants of Task B and for descendants of "linking words" like so:  
\<<:*id of "Task B"*&&>>:*id of "linking words"*    
Linking words can be considered a form of bi-directional links, so let's create a node called "bi-directional links" and copy "linking words" node as a child of it. Now we can search for all references to Task B:  
\<<:*id of "Task B"&&>>:*id of "bi-directional links"*  

## Templates  
 Template node is  a special type of a cloned node with  the following attributes:  

1)If node X is marked as a template node and node Y is copied from node X(to copy node X , Ctrl-Q when node X is selected and insert the copy anywhere in the knowledge base ),  then all nodes copied from Node Y will only mirror node Y.
So, other nodes copied from node X will not mirror node Y.
However, nodes copied from node Y will mirror node Y.  
Mirroring a node means that  if a child node Z is inserted/deleted under node A, node A's copied nodes insert/delete a copy of node Z as a child.   
2) it doesnt't accept mirrored nodes from it's cloned nodes   

Template nodes are used when nodes are not supposed to mirror all their copies copies, i.e. linking words, backlinks, templates.  
Let's create a daily document workflow by using the template functionality.  
Create a node "Templates" and insert a node "Day" as a child.  
Insert  nodes "Dump" and "TODO" as children of "Day".  
Mark "Day" and it's children as templates(Ctrl-P).  
Create a node "Daily document", and insert a node named after the current day (for example, "April 5th") as a child.  
Now copy the "Day" node(Ctrl-Q) and insert it as a child of "June 1st" node.  
By default, when a node  is inserted as a child of a node X that has copies, the inserted node will also be copied as a child of copies of Node X (if it has any).  
Marking "Day" and it's descendants as templates disables this behaviour  and makes these nodes not accept the newly inserted children from their copies, so "Day" node which descends from "Templates" will not receive the children of "Day" node which descends from "Daily Document". However, template nodes only block incoming nodes, so if a node Y is inserted as a child of a template node, the copied nodes will also insert the copy of node Y as a child(unless these nodes are also marked as a template).  

# Building  
The easiest way to build NodeFilter is through the QT Creator, as a project. You will also need to build Qt Quick 2  QML Treeview since it is distributed as a Qt extension.  
Dependencies:  
Qt 5.15  
QtQuick 2.15  
Qt Quick 2 QML Treeview - 	https://code.qt.io/cgit/qt-extensions/qttreeview.git/  
Note that Qt Quick 2 QML Treeview is not a part of core Qt and only builds with qmake in Qt5.   

# Installation  
Windows: download latest version from Releases.  
