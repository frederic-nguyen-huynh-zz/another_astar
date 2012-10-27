/**
 * Created with IntelliJ IDEA.
 * User: fredericn
 * Date: 26/10/12
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.dijkstra {
    import flash.utils.Dictionary;

    import org.frednh.IAlgorithm;
    import org.frednh.graph.INode;

    public class DijkstraAlgorithm implements IAlgorithm {

        public function DijkstraAlgorithm() {
        }

        public function execute(fromNode:INode, toNode:INode, nodesList:Vector.<INode>):Vector.<INode> {
            return getTheFastestWay(fromNode, toNode, nodesList);
        }

        public function get lastExecutionCost():int {
            return lastExecutionInc;
        }

        public function get trackNodesCount():int {
            return _trackNodesCount;
        }

        public function get redondance():int {
            return _redondance;
        }

        protected final function getTheFastestWay(fromNode:INode, toNode:INode, availableNodes:Vector.<INode>, useHeuristic:Boolean = false):Vector.<INode> {
            if (!toNode.isEnabled) {
                return null;
            }

            lastExecutionInc = 0;
            _redondance = 0;
            _trackNodesCount = 0;
            for each (var node:INode in availableNodes) {
                node.distanceInRoad = int.MAX_VALUE;
                node.heuristicDistanceInRoad = int.MAX_VALUE;
                node.checked = false;
            }

            fromNode.distanceInRoad = 0;
            fromNode.heuristicDistanceInRoad = 0;
            var availableNodes:Vector.<INode> = new Vector.<INode>();
            availableNodes.splice(availableNodes.indexOf(fromNode), 1);

            var roads:Dictionary = new Dictionary(true);
            var currentRoad:Vector.<INode> = new Vector.<INode>();
            currentRoad.push(fromNode);
            roads[fromNode] = currentRoad;

            while (true) {
                lastExecutionInc++;
                if (fromNode.checked) {
                    _redondance ++;
                } else {
                    _trackNodesCount++;
                }
                fromNode.checked = true;
                if (fromNode.distanceInRoad == int.MAX_VALUE) {
                    return null;
                }

                currentRoad = roads[fromNode];

                if (fromNode == toNode) {
                    return currentRoad;
                }

                // Updates successors distance in the road:
                var successorRoad:Vector.<INode>;
                for each (var successor:INode in fromNode.successors) {
                    if (!successor.isEnabled) {
                        continue;
                    }
                    lastExecutionInc++;

                    var distanceInRoad:int = fromNode.getVerticeValue(successor)
                                    + fromNode.distanceInRoad
                            ;
                    if (distanceInRoad > successor.distanceInRoad) {
                        continue;
                    }
                    successor.distanceInRoad = distanceInRoad;

                    successor.heuristicDistanceInRoad = distanceInRoad + successor.heuristicDistance(toNode);
                    successorRoad = currentRoad.concat();
                    successorRoad.push(successor);
                    roads[successor] = successorRoad;

                    var insertIndex:int = 0;

                    if (availableNodes.length == 0) {
                        availableNodes.push(successor);
                        continue;
                    }

                    if (availableNodes.indexOf(successor) != -1) {
                        continue;
                    }
                    while (availableNodes[insertIndex].heuristicDistanceInRoad < successor.heuristicDistanceInRoad

                            ) {
                        lastExecutionInc++;
                        insertIndex++;
                        if (insertIndex >= availableNodes.length - 1) {
                            break;
                        }
                    }
                    availableNodes.splice(insertIndex, 0, successor);
                }

                if (availableNodes.length <= 0) {
                    break;
                }

                currentRoad.push(fromNode);
                fromNode = availableNodes.shift();
            }

            return null;
        }

        private var _trackNodesCount : int = 0;
        private var _redondance : int = 0;

        public static var lastExecutionInc:int = 0;
    }
}
