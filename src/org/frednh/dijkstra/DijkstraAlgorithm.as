/**
 * Created with IntelliJ IDEA.
 * User: fredericn
 * Date: 26/10/12
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.dijkstra {
	import flash.utils.Dictionary;

	import org.frednh.graph.INode;
	import org.frednh.graph.Node;

	public class DijkstraAlgorithm {

		public function DijkstraAlgorithm() {
		}

		public function execute (fromNode : INode, toNode : INode, nodesList : Vector.<INode>) : Vector.<INode> {
			for each (var node : INode in nodesList) {
				node.distanceInRoad = int.MAX_VALUE;
			}

			fromNode.distanceInRoad = 0;

			var availableNodes:Vector.<INode> = nodesList.concat();
			availableNodes.splice(availableNodes.indexOf(fromNode), 1);
			return getTheFastestWay(fromNode, toNode, availableNodes);
		}

		internal static function getTheFastestWay (fromNode : INode, toNode : INode, availableNodes : Vector.<INode>) : Vector.<INode> {
			var roads : Dictionary = new Dictionary(true);
			var currentRoad : Vector.<INode> = new Vector.<INode>();
			currentRoad.push(fromNode);
			roads[fromNode] = currentRoad;

			while(availableNodes.length > 0) {
				if (fromNode.distanceInRoad == int.MAX_VALUE) {
					return null;
				}

				currentRoad = roads[fromNode];

				if (fromNode == toNode) {
					return currentRoad;
				}

				var successors : Vector.<INode> = fromNode.successors;

				// Updates successors distance in the road:
				var successorRoad : Vector.<INode>;
				for each (var successor : INode in successors) {

					var distanceInRoad:int = fromNode.getVerticeValue(successor) + fromNode.distanceInRoad;
					if (distanceInRoad > successor.distanceInRoad) {
						continue;
					}
					successor.distanceInRoad = distanceInRoad;
					successorRoad = currentRoad.concat();
					successorRoad.push(successor);
					roads[successor] = successorRoad;
				}
				availableNodes = availableNodes.sort(Node.minDistanceSorting);
//				trace("\tAvailable nodes: \n\t\t\t" +  availableNodes.join("\n\t\t\t") + "\n\t\t\t");
				fromNode = availableNodes.shift();
				currentRoad.push(fromNode);
			}
			return null;
		}

	}
}
