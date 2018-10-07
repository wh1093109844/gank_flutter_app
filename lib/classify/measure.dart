import 'dart:math';

class Position {
  int left;
  int top;
  int width;
  int height;

  Position({this.left, this.top, this.width, this.height});

  @override
  String toString() {
    // TODO: implement toString
    return 'Position(left: $left, top: $top, width: $width, height: $height)';
  }
}

class Block {
  List<Position> _children = [];
  List<List<int>> _matrix;
  int _maxItemSize;
  Block({columnNum = 3, rowNum = 3, maxItemSize = 3}):
      assert(columnNum > 0),
      assert(rowNum > 0),
      this._maxItemSize = maxItemSize {
    this._matrix = initBlock(columnNum, rowNum);
  }

  int get size => _children.length;
  Position get(int index) => _children[index];

  void next() {
    if (!isComplete()) {
      Position p = getPosition();
      _children.add(p);
      fillBlocks(p);
    }
  }

  bool isComplete() {
    bool result = true;
    for (int i = 0; i < _matrix.length; i++) {
      List<int> row = _matrix[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] == 0) {
          result = false;
          break;
        }
      }
      if (!result) {
        break;
      }
    }
    return result;
  }

  List<List<int>> initBlock(int width, int height) {
    List<List<int>> list = [];
    for (int i = 0; i < height; i++) {
      List<int> row = [];
      for (int j = 0; j < width; j++) {
        row.add(0);
      }
      list.add(row);
    }
    return list;
  }

  Position getPosition() {
    Point p = getStart();
    Point size = getSizePoint(p);
    return Position(left: p.x, top: p.y, width: size.x, height: size.y);
  }

  Point getSizePoint(Point p) {
    Random random = Random();
    int maxWidth = getMaxWidth(p);
    int maxHeight = min(_maxItemSize, _matrix.length - p.y);
    if (maxWidth == 3 && maxHeight < 2) {
      maxWidth = 1;
    }
    int width = random.nextInt(maxWidth) + 1;
    int height = width == 3 ? 2 : random.nextInt(maxHeight) + 1;
    return Point(width, height);
  }

  void fillBlocks(Position position) {
    for (int j = position.top; j < position.top + position.height; j++) {
      List<int> row = _matrix[j];
      for (int k = position.left; k < position.left + position.width; k++) {
        row[k] = 1;
      }
    }
  }

  Point<int> getStart() {
    int w = 0;
    int h = 0;
    for (h = 0; h < _matrix.length; h++) {
      List<int> row = _matrix[h];
      for (w = 0; w < row.length; w++) {
        if (row[w] == 0) {
          break;
        }
      }
      if (w < row.length) {
        break;
      }
    }
    return Point(w, h);
  }

  int getMaxWidth(Point<int> point) {
    int maxW = 1;
    for (int i = point.x + 1; i < _matrix[point.y].length; i++) {
      if (_matrix[point.y][i] == 0) {
        maxW += 1;
      } else {
        break;
      }
    }
    return min(maxW, _maxItemSize);
  }
}

class Measure {
  List<Block> blocks = <Block>[];
  int get length => blocks.length;
  void add(Block block) => blocks.add(block);

  int get total => blocks.map((block) => block.size).fold(0, (a, b) => a + b);

  Block getBlock(int index) {
    int total = 0;
    Block block = null;
    for (int i = 0; i < blocks.length; i++) {
      Block temp = blocks[i];
      if (index >= total && (!temp.isComplete() || (temp.isComplete() && index < total + temp.size))) {
        block = temp;
        break;
      }
    }
    if (block == null) {
      block = Block();
      blocks.add(block);
    }
    return block;
  }
}
