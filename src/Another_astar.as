package {

	import flash.display.Sprite;

	import org.frednh.dijkstra.DijkstraAlgorithm;
	import org.frednh.graph.INode;
	import org.frednh.graph.Node;

	[SWF(height=768, width=1024)]
	public class Another_astar extends Sprite {
		public function Another_astar() {

			var graph : Vector.<INode> = createTree ();
			var algo : DijkstraAlgorithm = new DijkstraAlgorithm();

			trace("----------------------> A GOING TO E");
			executeAlgo(algo, graph, 0, 4);
			trace("----------------------> A GOING TO D");
			executeAlgo(algo, graph, 0, 3);
			trace("----------------------> A GOING TO F");
			executeAlgo(algo, graph, 0, 5);
			trace("----------------------> A GOING TO G");
			executeAlgo(algo, graph, 0, 6);
			trace("----------------------> F GOING TO A");
			executeAlgo(algo, graph, 5, 0);
		}

		private function executeAlgo(algo:DijkstraAlgorithm, graph:Vector.<INode>, fromPoint:int, toPoint:int):void {
			var road:Vector.<INode> = algo.execute(graph[fromPoint], graph[toPoint], graph);

			if (null == road) {
				trace("I can not find a way...");
			} else {
				trace("Final road : " + road.join(" -> "));
			}
		}

		private function createTree () : Vector.<INode> {
			var nodeA : INode = new Node("A");
			var nodeB : INode = new Node("B");
			var nodeC : INode = new Node("C");
			var nodeD : INode = new Node("D");
			var nodeE : INode = new Node("E");
			var nodeF : INode = new Node("F");
			var nodeG : INode = new Node("G");

			nodeA.addSuccessor(nodeD, 6);
			nodeA.addSuccessor(nodeB, 0);
			nodeA.addSuccessor(nodeC, 4);
			nodeA.addSuccessor(nodeF, 0);

			nodeB.addSuccessor(nodeD, 2);
			nodeD.addSuccessor(nodeC, 1);
			nodeC.addSuccessor(nodeE, 10);
			nodeC.addSuccessor(nodeB, 2);

			nodeG.addSuccessor(nodeA, 0);

			var result : Vector.<INode> = new Vector.<INode>();

			result.push(nodeA);
			result.push(nodeB);
			result.push(nodeC);
			result.push(nodeD);
			result.push(nodeE);
			result.push(nodeF);
			result.push(nodeG);
			return result;

		}
	}
}
