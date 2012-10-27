/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 26/10/12
 * Time: 22:22
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {
    public class Grid  {

        public function Grid(width:int, heigth:int) {
            init(heigth, width);
        }

        public function toString():String {
            var row:String = "Grid " + _width + "x" + _height + "\n";
            return row;
        }

        public function get width():int {
            return _width;
        }

        public function get height():int {
            return _height;
        }

        public function get nodes () : Vector.<INode> {
            return _gridNodes;
        }

        public function getNode(x, y):IGridNode {
            return _gridNodes[x + y * _width]  as IGridNode;
        }

        public function getLeft(node:IGridNode):IGridNode {
            return getNode(node.x - 1, node.y);
        }

        public function getRight(node:IGridNode):IGridNode {
            return getNode(node.x + 1, node.y);
        }

        public function getTop(node:IGridNode):IGridNode {
            return getNode(node.x, node.y - 1);
        }

        public function getBottom(node:IGridNode):IGridNode {
            return getNode(node.x, node.y + 1);
        }

        private function init(height:int, width:int):void {
            _gridNodes = new Vector.<INode>();

            _height = height;
            _width = width;


            for (var row:int = 0; row < _height; row++) {
                for (var col:int = 0; col < _width; col++) {
                    // TODO : DO not generate altitude here....
                    var altitude : int = Math.random() * 5 * int(Math.random() * 2);

                    _gridNodes.push(new GridNode(col + "x" + row, col, row, altitude));
                }
            }

            for (var cursor:int = 0; cursor < (_height * _width); cursor++) {
                var node:IGridNode = _gridNodes[cursor] as IGridNode;
                // add left node
                if (node.x > 0) {
                    node.addSuccessor(getLeft(node), 1);
                }
                // add right node
                if (node.x < (_width - 1)) {
                    node.addSuccessor(getRight(node), 1);
                }
                // add top node
                if (node.y > 0) {
                    node.addSuccessor(getTop(node), 1);
                }

                // add bottom node
                if (node.y < (_height - 1)) {
                    node.addSuccessor(getBottom(node), 1);
                }

            }

        }


        private var _width:int;
        private var _height:int;
        private var _gridNodes:Vector.<INode>;
    }
}
