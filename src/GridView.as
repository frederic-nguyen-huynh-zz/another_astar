/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 00:46
 * To change this template use File | Settings | File Templates.
 */
package {
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.utils.getTimer;

    import org.frednh.compression.CompressedRoad;
    import org.frednh.graph.Grid;
    import org.frednh.graph.IGridNode;
    import org.frednh.graph.INode;
    import org.frednh.graph.NodeEvent;
    import org.test.AvatarModel;
    import org.test.AvatarView;

    public class GridView extends Sprite {


        public function GridView(grid:Grid, avatarModel : AvatarModel) {
            super();
            _grid = grid;
            _avatarModel = avatarModel;
            _avatarView = new AvatarView(avatarModel, _CELL_SIZE, _CELL_MARGIN);
            _roadClip = new Shape();
            this.addChild(_roadClip);
            this.addChild(_avatarView);
            updateDraw();
            this.addEventListener(MouseEvent.CLICK, onClick);
        }

        private function onClick(event:MouseEvent):void {
            var positionX:int = event.localX / (_CELL_SIZE + _CELL_MARGIN);
            var positionY:int = (event.localY / (_CELL_SIZE + _CELL_MARGIN));
            dispatchEvent(new NodeEvent(NodeEvent.MOVE_TO_NODE, positionX, positionY));
        }

        public function drawRoad(road:Vector.<INode>):void {
            var startTimer:Number = getTimer();
            var roadGraphics:Graphics = _roadClip.graphics;

            roadGraphics.clear();

            for (var i : int = 0; i < road.length; i++) {
                var node : INode = road[i];
                var color : uint = _INROAD_COLOR;
                if (i == 0) { color = _INROAD_COLOR_FIRST; }
                if (i == road.length - 1) { color = _INROAD_COLOR_LAST; }

                roadGraphics.beginFill(color, 0.5);
                roadGraphics.drawRect(
                        IGridNode(node).x * (_CELL_SIZE + _CELL_MARGIN)
                        , IGridNode(node).y * (_CELL_SIZE + _CELL_MARGIN)
                        , _CELL_SIZE, _CELL_SIZE);
                roadGraphics.endFill();

            }
            trace("Drawing duration: " + (getTimer() - startTimer));
            return;
        }

        public function moveModel (compressedRoad : CompressedRoad) : void {
            _avatarView.move(compressedRoad);
        }

        private function updateDraw():void {
            graphics.clear();

            graphics.beginFill(_TOUCH_COLOR);
            graphics.drawRect(0, 0, _grid.width * (_CELL_SIZE + _CELL_MARGIN), _grid.height * (_CELL_SIZE + _CELL_MARGIN));
            graphics.endFill();


            for (var row:int = 0; row < _grid.height; row++) {
                for (var col:int = 0; col < _grid.width; col++) {

                    var node:IGridNode = _grid.getNode(col, row);
                    var color:uint = _INACTIVE_COLOR;

                    var alpha : Number = 0.4 + (0.2 * node.z);

                    if (!node.isEnabled) {
                        alpha = 1;
                        color = _DISABLED_COLOR;
                    }

                    graphics.beginFill(color, alpha);
                    graphics.drawRect(
                            col * (_CELL_SIZE + _CELL_MARGIN)
                            , row * (_CELL_SIZE + _CELL_MARGIN)
                            , _CELL_SIZE, _CELL_SIZE);
                    graphics.endFill();

                }
            }


        }

        private var _grid:Grid;
        private var _roadClip : Shape;
        private var _avatarModel : AvatarModel;
        private var _avatarView : AvatarView;



        private static const _DISABLED_COLOR:uint = 0xDD3333;
        private static const _INACTIVE_COLOR:uint = 0xCC77AA;
        private static const _TOUCH_COLOR:uint = 0xFFFFFF;

        private static const _INROAD_COLOR_FIRST:uint = 0x004400;
        private static const _INROAD_COLOR:uint = 0x11AA11;
        private static const _INROAD_COLOR_LAST:uint = 0x11FF11;

        private static const _CELL_SIZE:int = 20;
        private static const _CELL_MARGIN:int = 1;
    }
}
