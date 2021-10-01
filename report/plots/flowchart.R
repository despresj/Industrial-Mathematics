DiagrammeR::grViz("digraph {
  graph [layout = dot, rankdir = TB]
  
  node [shape = rectangle]        
  rec1 [label = '1. Specify hotel capacity and cost of overbooking']
  rec2 [label = '2. Estimate probability of a guest arriving given relevant factors']
  rec3 [label = '3. Using the estimated probability estimate the fraction of hotel capacity']
  rec4 [label = '4. Valadate the method using resampling simulation']
  
  # edge definitions with the node IDs
  rec1 -> rec2 -> rec3 -> rec4
  }",
  height = 500)
