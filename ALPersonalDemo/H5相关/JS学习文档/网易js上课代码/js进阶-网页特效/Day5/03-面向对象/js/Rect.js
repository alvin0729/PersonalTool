function Rect(option) {
    this._init(option);
}

Rect.prototype = {
    _init: function (option) {
        option = option || {};

        // 父标签的id
        this.parentId = option.parentId;

        // 位置
        this.left = option.left || 100;
        this.top = option.top || 100;

        // 自身属性
        this.width = option.width || 100;
        this.height = option.height || 50;
        this.backgroundColor = option.backgroundColor || 'blue';
        this.border = option.border || 0;
        this.borderRadius = option.borderRadius || 0;
    },

    // 绘制矩形
    render: function () {
        var parentNode = document.getElementById(this.parentId);
        var childNode = document.createElement("div");

        childNode.style.position = "absolute";
        childNode.style.left = this.left + "px";
        childNode.style.top = this.top + "px";

        childNode.style.width = this.width + "px";
        childNode.style.height = this.height + "px";
        childNode.style.backgroundColor = this.backgroundColor;
        childNode.style.border = this.border;
        childNode.style.borderRadius = this.borderRadius + "px";

        parentNode.appendChild(childNode);

    }
};
