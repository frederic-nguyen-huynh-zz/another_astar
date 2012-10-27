/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 17:09
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.compression {
    import org.frednh.graph.INode;

    public class CompressedRoad {
        public function CompressedRoad(startingNode:INode, roadNodes:Vector.<RoadNode>) {
            _startingNode = startingNode;
            _roadNodes = roadNodes;
        }

        public function get startingNode():INode {
            return _startingNode;
        }

        public function get roadNodes():Vector.<RoadNode> {
            return _roadNodes;
        }

        public function toString():String {
            return roadNodes.length + ", from " + _startingNode + ", going : " + roadNodes.join(",");
        }

        private var _startingNode:INode;
        private var _roadNodes:Vector.<RoadNode>;
    }
}
