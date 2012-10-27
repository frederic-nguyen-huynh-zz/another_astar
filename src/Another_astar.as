package {

    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.utils.getTimer;

    import org.frednh.IAlgorithm;
    import org.frednh.astar.AStarAlgorithm;
    import org.frednh.compression.CompressedRoad;
    import org.frednh.compression.RoadCompression;
    import org.frednh.dijkstra.DijkstraAlgorithm;
    import org.frednh.graph.Grid;
    import org.frednh.graph.IGridNode;
    import org.frednh.graph.INode;
    import org.frednh.graph.Node;
    import org.frednh.graph.NodeEvent;
    import org.test.AvatarModel;

    [SWF(height=768, width=1024, frameRate=32)]
    public class Another_astar extends Sprite {

        public function Another_astar() {
//            dijkstra();
            astar();
            stage.scaleMode = StageScaleMode.NO_SCALE;
        }

        private function dijkstra():void {
            trace("-----------------  DIJKSTRA METHOD  ------------------")
            var algo:IAlgorithm = new DijkstraAlgorithm();
            var graph:Vector.<INode> = createTree();

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

            var grid:Grid = new Grid(8, 5);
            trace("\n_\n_\nNOW, WHAT IF WE WORK ON A GRID?");
            trace("Grid: " + grid);

            trace("Going from 1x1 to 5x4");
            var from:INode = grid.getNode(3, 2);
            var to:INode = grid.getNode(5, 4);
            var graph:Vector.<INode> = grid.nodes;
            var road:Vector.<INode> = algo.execute(from, to, graph);
            trace("O=" + algo.lastExecutionCost + " | " + road.join(" -> "));

            trace("Now, I want to find another way:")
            from.removeSuccessor(grid.getRight(from as IGridNode));
            from.removeSuccessor(grid.getBottom(from as IGridNode));
            road = algo.execute(from, to, graph);
            trace("O=" + algo.lastExecutionCost + " | " + road.join(" -> "));

            var gridView:GridView = new GridView(grid, _avatarModel);
            this.addChild(gridView);
            gridView.drawRoad(road);

        }

        private function astar():void {
            trace("\n-\n-\n-----------------  A*  METHOD  ------------------")
            _graph = new Grid(50, 50);
            createWall();
            _actualNode = _graph.getNode(0, 0);

            _graphView = new GridView(_graph, _avatarModel);
            this.addChild(_graphView);
            _graphView.x = 10;

            _graphView.addEventListener(NodeEvent.MOVE_TO_NODE, onMoveToNode);
        }

        private function onMoveToNode(event:NodeEvent):void {
            var to:INode = _graph.getNode(event.nodeX, event.nodeY);
            trace("Moving to : " + to, " Is ok: " + to.isEnabled);
            var graph:Vector.<INode> = _graph.nodes;
            var startTimer:Number = getTimer();

            var road:Vector.<INode> = _algorithm.execute(_actualNode, to, graph);
            if (road == null) {
                return;
            }
            trace("-------------- A STAR RESULT : ");
            trace("Algorithm duration: " + (getTimer() - startTimer));
            trace("Execution cost: " + _algorithm.lastExecutionCost);
            trace("Track nodes count: " + _algorithm.trackNodesCount);
            trace("Redondance: " + _algorithm.redondance);

            _graphView.drawRoad(road);
            _actualNode = to;

            var compressedRoad:CompressedRoad = _roadCompression.execute(road);
            _graphView.moveModel(compressedRoad);
            trace("-------------- ROAD COMPRESSION : ");
            trace("Execution cost: " + _roadCompression.lastExecutionCost);
            trace("Track nodes count: " + _roadCompression.trackNodesCount);
            trace("Uncompressed road size:" + road.length);
            trace("Compressed road :" + compressedRoad);
        }

        private function executeAlgo(algo:IAlgorithm, graph:Vector.<INode>, fromPoint:int, toPoint:int):void {
            var road:Vector.<INode> = algo.execute(graph[fromPoint], graph[toPoint], graph);

            if (null == road) {
                trace("I can not find a way...");
            } else {
                trace("O=" + algo.lastExecutionCost + " | Final road : " + road.join(" -> "));
            }
        }

        private function createTree():Vector.<INode> {
            var nodeA:INode = new Node("A");
            var nodeB:INode = new Node("B");
            var nodeC:INode = new Node("C");
            var nodeD:INode = new Node("D");
            var nodeE:INode = new Node("E");
            var nodeF:INode = new Node("F");
            var nodeG:INode = new Node("G");

            nodeA.addSuccessor(nodeD, 6);
            nodeA.addSuccessor(nodeB, 0);
            nodeA.addSuccessor(nodeC, 4);
            nodeA.addSuccessor(nodeF, 0);

            nodeB.addSuccessor(nodeD, 2);
            nodeD.addSuccessor(nodeC, 1);
            nodeC.addSuccessor(nodeE, 10);
            nodeC.addSuccessor(nodeB, 2);

            nodeG.addSuccessor(nodeA, 0);

            var result:Vector.<INode> = new Vector.<INode>();

            result.push(nodeA);
            result.push(nodeB);
            result.push(nodeC);
            result.push(nodeD);
            result.push(nodeE);
            result.push(nodeF);
            result.push(nodeG);
            return result;

        }

        private function createWall():void {
            var graph:Vector.<INode> = _graph.nodes.concat();

            for (var i:uint = 0; i < graph.length / 4; i++) {
                var position:int = Math.random() * (graph.length - 1) + 1;

                var node:INode = graph.splice(position, 1)[0];
                node.isEnabled = false;
            }
        }

        private var _graphView:GridView;
        private var _graph:Grid;
        private var _actualNode:INode;
        private var _avatarModel : AvatarModel = new AvatarModel();


        private var _roadCompression:RoadCompression = new RoadCompression();
        private var _algorithm:IAlgorithm = new AStarAlgorithm();


    }
}
