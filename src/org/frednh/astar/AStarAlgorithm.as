/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 00:18
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.astar {
    import org.frednh.IAlgorithm;
    import org.frednh.dijkstra.DijkstraAlgorithm;
    import org.frednh.graph.INode;

    public class AStarAlgorithm extends DijkstraAlgorithm implements IAlgorithm{

        public function AStarAlgorithm() {
        }

        override public function execute(fromNode:INode, toNode:INode, nodesList:Vector.<INode>):Vector.<INode> {
            return getTheFastestWay(fromNode, toNode, nodesList, true);
        }


    }
}
