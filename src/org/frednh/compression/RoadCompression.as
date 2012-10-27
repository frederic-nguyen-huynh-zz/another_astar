/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 16:30
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.compression {
    import org.frednh.graph.IGridNode;
    import org.frednh.graph.INode;

    public class RoadCompression {

        public function RoadCompression() {
        }

        /**
         *
         * @param nodesList Road
         * @return
         */
        public function execute(nodesList:Vector.<INode>):CompressedRoad {

            _lastExecutionCost = _redondance = _trackNodesCount = 0;

            var currentRoadNode:RoadNode = new RoadNode(new RoadDirection(
                    "START_NULL"
                    , 0, 0
            ));
            var currentNode:IGridNode;
            var lastNode:IGridNode;

            var compressedRoad:Vector.<RoadNode> = new Vector.<RoadNode>();

            for (var i:uint = 1; i < nodesList.length; i++) {
                _lastExecutionCost++;

                currentNode = nodesList[i] as IGridNode;
                lastNode = nodesList[i - 1] as IGridNode;
                _trackNodesCount++;

                var translation:RoadDirection = new RoadDirection(
                        "MATCHER"
                        , currentNode.x - lastNode.x
                        , currentNode.y - lastNode.y);

                if (currentRoadNode.direction.x != translation.x
                        || currentRoadNode.direction.y != translation.y
                        ) {
                    currentRoadNode = new RoadNode(translation);
                    compressedRoad.push(currentRoadNode);
                }
                currentRoadNode.duration++;
            }

            return new CompressedRoad(nodesList[0], compressedRoad);
        }

        public function get redondance():int {
            return _redondance;
        }

        public function get trackNodesCount():int {
            return _trackNodesCount;
        }

        public function get lastExecutionCost():int {
            return _lastExecutionCost;
        }

        private var _redondance:int = 0.
        private var _trackNodesCount:int = 0;
        private var _lastExecutionCost:int = 0;

    }
}
