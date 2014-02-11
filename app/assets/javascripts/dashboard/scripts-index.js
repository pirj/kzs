/*! gridster.js - v0.2.1 - 2013-10-28 - * http://gridster.net/ - Copyright (c) 2013 ducksboard; Licensed MIT */
!function (a) {
    function b(b) {
        return b[0] && a.isPlainObject(b[0]) ? this.data = b[0] : this.el = b, this.isCoords = !0, this.coords = {}, this.init(), this
    }

    var c = b.prototype;
    c.init = function () {
        this.set(), this.original_coords = this.get()
    }, c.set = function (a, b) {
        var c = this.el;
        if (c && !a && (this.data = c.offset(), this.data.width = c.width(), this.data.height = c.height()), c && a && !b) {
            var d = c.offset();
            this.data.top = d.top, this.data.left = d.left
        }
        var e = this.data;
        return this.coords.x1 = e.left, this.coords.y1 = e.top, this.coords.x2 = e.left + e.width, this.coords.y2 = e.top + e.height, this.coords.cx = e.left + e.width / 2, this.coords.cy = e.top + e.height / 2, this.coords.width = e.width, this.coords.height = e.height, this.coords.el = c || !1, this
    }, c.update = function (b) {
        if (!b && !this.el)return this;
        if (b) {
            var c = a.extend({}, this.data, b);
            return this.data = c, this.set(!0, !0)
        }
        return this.set(!0), this
    }, c.get = function () {
        return this.coords
    }, a.fn.coords = function () {
        if (this.data("coords"))return this.data("coords");
        var a = new b(this, arguments[0]);
        return this.data("coords", a), a
    }
}(jQuery, window, document), function (a, b, c) {
    function d(b, c, d) {
        this.options = a.extend(e, d), this.$element = b, this.last_colliders = [], this.last_colliders_coords = [], "string" == typeof c || c instanceof jQuery ? this.$colliders = a(c, this.options.colliders_context).not(this.$element) : this.colliders = a(c), this.init()
    }

    var e = {colliders_context: c.body}, f = d.prototype;
    f.init = function () {
        this.find_collisions()
    }, f.overlaps = function (a, b) {
        var c = !1, d = !1;
        return(b.x1 >= a.x1 && b.x1 <= a.x2 || b.x2 >= a.x1 && b.x2 <= a.x2 || a.x1 >= b.x1 && a.x2 <= b.x2) && (c = !0), (b.y1 >= a.y1 && b.y1 <= a.y2 || b.y2 >= a.y1 && b.y2 <= a.y2 || a.y1 >= b.y1 && a.y2 <= b.y2) && (d = !0), c && d
    }, f.detect_overlapping_region = function (a, b) {
        var c = "", d = "";
        return a.y1 > b.cy && a.y1 < b.y2 && (c = "N"), a.y2 > b.y1 && a.y2 < b.cy && (c = "S"), a.x1 > b.cx && a.x1 < b.x2 && (d = "W"), a.x2 > b.x1 && a.x2 < b.cx && (d = "E"), c + d || "C"
    }, f.calculate_overlapped_area_coords = function (b, c) {
        var d = Math.max(b.x1, c.x1), e = Math.max(b.y1, c.y1), f = Math.min(b.x2, c.x2), g = Math.min(b.y2, c.y2);
        return a({left: d, top: e, width: f - d, height: g - e}).coords().get()
    }, f.calculate_overlapped_area = function (a) {
        return a.width * a.height
    }, f.manage_colliders_start_stop = function (b, c, d) {
        for (var e = this.last_colliders_coords, f = 0, g = e.length; g > f; f++)-1 === a.inArray(e[f], b) && c.call(this, e[f]);
        for (var h = 0, i = b.length; i > h; h++)-1 === a.inArray(b[h], e) && d.call(this, b[h])
    }, f.find_collisions = function (b) {
        for (var c = this, d = [], e = [], f = this.colliders || this.$colliders, g = f.length, h = c.$element.coords().update(b || !1).get(); g--;) {
            var i = c.$colliders ? a(f[g]) : f[g], j = i.isCoords ? i : i.coords(), k = j.get(), l = c.overlaps(h, k);
            if (l) {
                var m = c.detect_overlapping_region(h, k);
                if ("C" === m) {
                    var n = c.calculate_overlapped_area_coords(h, k), o = c.calculate_overlapped_area(n), p = {area: o, area_coords: n, region: m, coords: k, player_coords: h, el: i};
                    c.options.on_overlap && c.options.on_overlap.call(this, p), d.push(j), e.push(p)
                }
            }
        }
        return(c.options.on_overlap_stop || c.options.on_overlap_start) && this.manage_colliders_start_stop(d, c.options.on_overlap_start, c.options.on_overlap_stop), this.last_colliders_coords = d, e
    }, f.get_closest_colliders = function (a) {
        var b = this.find_collisions(a);
        return b.sort(function (a, b) {
            return"C" === a.region && "C" === b.region ? a.coords.y1 < b.coords.y1 || a.coords.x1 < b.coords.x1 ? -1 : 1 : a.area < b.area ? 1 : 1
        }), b
    }, a.fn.collision = function (a, b) {
        return new d(this, a, b)
    }
}(jQuery, window, document), function (a) {
    a.delay = function (a, b) {
        var c = Array.prototype.slice.call(arguments, 2);
        return setTimeout(function () {
            return a.apply(null, c)
        }, b)
    }, a.debounce = function (a, b, c) {
        var d;
        return function () {
            var e = this, f = arguments, g = function () {
                d = null, c || a.apply(e, f)
            };
            c && !d && a.apply(e, f), clearTimeout(d), d = setTimeout(g, b)
        }
    }, a.throttle = function (a, b) {
        var c, d, e, f, g, h, i = debounce(function () {
            g = f = !1
        }, b);
        return function () {
            c = this, d = arguments;
            var j = function () {
                e = null, g && a.apply(c, d), i()
            };
            return e || (e = setTimeout(j, b)), f ? g = !0 : h = a.apply(c, d), i(), f = !0, h
        }
    }
}(window), function (a, b, c) {
    function d(b, d) {
        this.options = a.extend({}, e, d), this.$body = a(c.body), this.$container = a(b), this.$dragitems = a(this.options.items, this.$container), this.is_dragging = !1, this.player_min_left = 0 + this.options.offset_left, this.init()
    }

    var e = {items: "li", distance: 1, limit: !0, offset_left: 0, autoscroll: !0, ignore_dragging: ["INPUT", "TEXTAREA", "SELECT", "BUTTON"], handle: null, container_width: 0, move_element: !0, helper: !1}, f = a(b), g = !!("ontouchstart"in b), h = {start: g ? "touchstart.gridster-draggable" : "mousedown.gridster-draggable", move: g ? "touchmove.gridster-draggable" : "mousemove.gridster-draggable", end: g ? "touchend.gridster-draggable" : "mouseup.gridster-draggable"}, i = d.prototype;
    i.init = function () {
        this.calculate_positions(), this.$container.css("position", "relative"), this.disabled = !1, this.events(), a(b).bind("resize.gridster-draggable", throttle(a.proxy(this.calculate_positions, this), 200))
    }, i.events = function () {
        this.$container.on("selectstart.gridster-draggable", a.proxy(this.on_select_start, this)), this.$container.on(h.start, this.options.items, a.proxy(this.drag_handler, this)), this.$body.on(h.end, a.proxy(function (a) {
            this.is_dragging = !1, this.disabled || (this.$body.off(h.move), this.drag_start && this.on_dragstop(a))
        }, this))
    }, i.get_actual_pos = function (a) {
        var b = a.position();
        return b
    }, i.get_mouse_pos = function (a) {
        if (g) {
            var b = a.originalEvent;
            a = b.touches.length ? b.touches[0] : b.changedTouches[0]
        }
        return{left: a.clientX, top: a.clientY}
    }, i.get_offset = function (a) {
        a.preventDefault();
        var b = this.get_mouse_pos(a), c = Math.round(b.left - this.mouse_init_pos.left), d = Math.round(b.top - this.mouse_init_pos.top), e = Math.round(this.el_init_offset.left + c - this.baseX), f = Math.round(this.el_init_offset.top + d - this.baseY + this.scrollOffset);
        return this.options.limit && (e > this.player_max_left ? e = this.player_max_left : e < this.player_min_left && (e = this.player_min_left)), {position: {left: e, top: f}, pointer: {left: b.left, top: b.top, diff_left: c, diff_top: d + this.scrollOffset}}
    }, i.get_drag_data = function (a) {
        var b = this.get_offset(a);
        return b.$player = this.$player, b.$helper = this.helper ? this.$helper : this.$player, b
    }, i.manage_scroll = function (a) {
        var b, c = f.scrollTop(), d = c, e = d + this.window_height, g = e - 50, h = d + 50;
        a.pointer.left;
        var i = d + a.pointer.top, j = this.doc_height - this.window_height + this.player_height;
        i >= g && (b = c + 30, j > b && (f.scrollTop(b), this.scrollOffset = this.scrollOffset + 30)), h >= i && (b = c - 30, b > 0 && (f.scrollTop(b), this.scrollOffset = this.scrollOffset - 30))
    }, i.calculate_positions = function () {
        this.window_height = f.height()
    }, i.drag_handler = function (b) {
        if (b.target.nodeName, !this.disabled && (1 === b.which || g) && !this.ignore_drag(b)) {
            var c = this, d = !0;
            return this.$player = a(b.currentTarget), this.el_init_pos = this.get_actual_pos(this.$player), this.mouse_init_pos = this.get_mouse_pos(b), this.offsetY = this.mouse_init_pos.top - this.el_init_pos.top, this.$body.on(h.move, function (a) {
                var b = c.get_mouse_pos(a), e = Math.abs(b.left - c.mouse_init_pos.left), f = Math.abs(b.top - c.mouse_init_pos.top);
                return e > c.options.distance || f > c.options.distance ? d ? (d = !1, c.on_dragstart.call(c, a), !1) : (c.is_dragging === !0 && c.on_dragmove.call(c, a), !1) : !1
            }), g ? void 0 : !1
        }
    }, i.on_dragstart = function (b) {
        if (b.preventDefault(), this.is_dragging)return this;
        this.drag_start = this.is_dragging = !0;
        var d = this.$container.offset();
        this.baseX = Math.round(d.left), this.baseY = Math.round(d.top), this.doc_height = a(c).height(), "clone" === this.options.helper ? (this.$helper = this.$player.clone().appendTo(this.$container).addClass("helper"), this.helper = !0) : this.helper = !1, this.scrollOffset = 0, this.el_init_offset = this.$player.offset(), this.player_width = this.$player.width(), this.player_height = this.$player.height();
        var e = this.options.container_width || this.$container.width();
        return this.player_max_left = e - this.player_width + this.options.offset_left, this.options.start && this.options.start.call(this.$player, b, this.get_drag_data(b)), !1
    }, i.on_dragmove = function (a) {
        var b = this.get_drag_data(a);
        this.options.autoscroll && this.manage_scroll(b), this.options.move_element && (this.helper ? this.$helper : this.$player).css({position: "absolute", left: b.position.left, top: b.position.top});
        var c = this.last_position || b.position;
        return b.prev_position = c, this.options.drag && this.options.drag.call(this.$player, a, b), this.last_position = b.position, !1
    }, i.on_dragstop = function (a) {
        var b = this.get_drag_data(a);
        return this.drag_start = !1, this.options.stop && this.options.stop.call(this.$player, a, b), this.helper && this.$helper.remove(), !1
    }, i.on_select_start = function (a) {
        return this.disabled || this.ignore_drag(a) ? void 0 : !1
    }, i.enable = function () {
        this.disabled = !1
    }, i.disable = function () {
        this.disabled = !0
    }, i.destroy = function () {
        this.disable(), this.$container.off(".gridster-draggable"), this.$body.off(".gridster-draggable"), a(b).off(".gridster-draggable"), a.removeData(this.$container, "drag")
    }, i.ignore_drag = function (b) {
        return this.options.handle ? !a(b.target).is(this.options.handle) : a(b.target).is(this.options.ignore_dragging.join(", "))
    }, a.fn.drag = function (a) {
        return new d(this, a)
    }
}(jQuery, window, document), function (a, b, c) {
    function d(b, c) {
        this.options = a.extend(!0, e, c), this.$el = a(b), this.$wrapper = this.$el.parent(), this.$widgets = this.$el.children(this.options.widget_selector).addClass("gs-w"), this.widgets = [], this.$changed = a([]), this.wrapper_width = this.$wrapper.width(), this.min_widget_width = 2 * this.options.widget_margins[0] + this.options.widget_base_dimensions[0], this.min_widget_height = 2 * this.options.widget_margins[1] + this.options.widget_base_dimensions[1], this.$style_tags = a([]), this.init()
    }

    var e = {namespace: "", widget_selector: "li", widget_margins: [10, 10], widget_base_dimensions: [400, 225], extra_rows: 0, extra_cols: 0, min_cols: 1, max_cols: null, min_rows: 15, max_size_x: !1, autogenerate_stylesheet: !0, avoid_overlapped_widgets: !0, serialize_params: function (a, b) {
        return{col: b.col, row: b.row, size_x: b.size_x, size_y: b.size_y}
    }, collision: {}, draggable: {items: ".gs-w", distance: 4}, resize: {enabled: !1, axes: ["x", "y", "both"], handle_append_to: "", handle_class: "gs-resize-handle", max_size: [1 / 0, 1 / 0]}};
    d.generated_stylesheets = [];
    var f = d.prototype;
    f.init = function () {
        this.options.resize.enabled && this.setup_resize(), this.generate_grid_and_stylesheet(), this.get_widgets_from_DOM(), this.set_dom_grid_height(), this.$wrapper.addClass("ready"), this.draggable(), this.options.resize.enabled && this.resizable(), a(b).bind("resize.gridster", throttle(a.proxy(this.recalculate_faux_grid, this), 200))
    }, f.disable = function () {
        return this.$wrapper.find(".player-revert").removeClass("player-revert"), this.drag_api.disable(), this
    }, f.enable = function () {
        return this.drag_api.enable(), this
    }, f.disable_resize = function () {
        return this.$el.addClass("gs-resize-disabled"), this.resize_api.disable(), this
    }, f.enable_resize = function () {
        return this.$el.removeClass("gs-resize-disabled"), this.resize_api.enable(), this
    }, f.add_widget = function (b, c, d, e, f, g) {
        var h;
        c || (c = 1), d || (d = 1), !e & !f ? h = this.next_position(c, d) : (h = {col: e, row: f}, this.empty_cells(e, f, c, d));
        var i = a(b).attr({"data-col": h.col, "data-row": h.row, "data-sizex": c, "data-sizey": d}).addClass("gs-w").appendTo(this.$el).hide();
        return this.$widgets = this.$widgets.add(i), this.register_widget(i), this.add_faux_rows(h.size_y), g && this.set_widget_max_size(i, g), this.set_dom_grid_height(), i.fadeIn()
    }, f.set_widget_max_size = function (a, b) {
        if (a = "number" == typeof a ? this.$widgets.eq(a) : a, !a.length)return this;
        var c = a.data("coords").grid;
        return c.max_size_x = b[0], c.max_size_y = b[1], this
    }, f.add_resize_handle = function (b) {
        var c = this.options.resize.handle_append_to;
        return a(this.resize_handle_tpl).appendTo(c ? a(c, b) : b), this
    }, f.resize_widget = function (a, b, c, d, e) {
        var f = a.coords().grid;
        d !== !1 && (d = !0), b || (b = f.size_x), c || (c = f.size_y), b > this.cols && (b = this.cols);
        var g = f.size_y, h = f.col, i = h;
        if (d && h + b - 1 > this.cols) {
            var j = h + (b - 1) - this.cols, k = h - j;
            i = Math.max(1, k)
        }
        c > g && this.add_faux_rows(Math.max(c - g, 0));
        var l = {col: i, row: f.row, size_x: b, size_y: c};
        return this.mutate_widget_in_gridmap(a, f, l), this.set_dom_grid_height(), e && e.call(this, l.size_x, l.size_y), a
    }, f.mutate_widget_in_gridmap = function (b, c, d) {
        c.size_x;
        var e = c.size_y, f = this.get_cells_occupied(c), g = this.get_cells_occupied(d), h = [];
        a.each(f.cols, function (b, c) {
            -1 === a.inArray(c, g.cols) && h.push(c)
        });
        var i = [];
        a.each(g.cols, function (b, c) {
            -1 === a.inArray(c, f.cols) && i.push(c)
        });
        var j = [];
        a.each(f.rows, function (b, c) {
            -1 === a.inArray(c, g.rows) && j.push(c)
        });
        var k = [];
        if (a.each(g.rows, function (b, c) {
            -1 === a.inArray(c, f.rows) && k.push(c)
        }), this.remove_from_gridmap(c), i.length) {
            var l = [d.col, d.row, d.size_x, Math.min(e, d.size_y), b];
            this.empty_cells.apply(this, l)
        }
        if (k.length) {
            var m = [d.col, d.row, d.size_x, d.size_y, b];
            this.empty_cells.apply(this, m)
        }
        if (c.col = d.col, c.row = d.row, c.size_x = d.size_x, c.size_y = d.size_y, this.add_to_gridmap(d, b), b.removeClass("player-revert"), b.data("coords").update({width: d.size_x * this.options.widget_base_dimensions[0] + 2 * (d.size_x - 1) * this.options.widget_margins[0], height: d.size_y * this.options.widget_base_dimensions[1] + 2 * (d.size_y - 1) * this.options.widget_margins[1]}), b.attr({"data-col": d.col, "data-row": d.row, "data-sizex": d.size_x, "data-sizey": d.size_y}), h.length) {
            var n = [h[0], d.row, h.length, Math.min(e, d.size_y), b];
            this.remove_empty_cells.apply(this, n)
        }
        if (j.length) {
            var o = [d.col, d.row, d.size_x, d.size_y, b];
            this.remove_empty_cells.apply(this, o)
        }
        return this.move_widget_up(b), this
    }, f.empty_cells = function (b, c, d, e, f) {
        var g = this.widgets_below({col: b, row: c - e, size_x: d, size_y: e});
        return g.not(f).each(a.proxy(function (b, d) {
            var f = a(d).coords().grid;
            if (f.row <= c + e - 1) {
                var g = c + e - f.row;
                this.move_widget_down(a(d), g)
            }
        }, this)), this.set_dom_grid_height(), this
    }, f.remove_empty_cells = function (b, c, d, e, f) {
        var g = this.widgets_below({col: b, row: c, size_x: d, size_y: e});
        return g.not(f).each(a.proxy(function (b, c) {
            this.move_widget_up(a(c), e)
        }, this)), this.set_dom_grid_height(), this
    }, f.next_position = function (a, b) {
        a || (a = 1), b || (b = 1);
        for (var c, d = this.gridmap, e = d.length, f = [], g = 1; e > g; g++) {
            c = d[g].length;
            for (var h = 1; c >= h; h++) {
                var i = this.can_move_to({size_x: a, size_y: b}, g, h);
                i && f.push({col: g, row: h, size_y: b, size_x: a})
            }
        }
        return f.length ? this.sort_by_row_and_col_asc(f)[0] : !1
    }, f.remove_widget = function (b, c, d) {
        var e = b instanceof jQuery ? b : a(b), f = e.coords().grid;
        a.isFunction(c) && (d = c, c = !1), this.cells_occupied_by_placeholder = {}, this.$widgets = this.$widgets.not(e);
        var g = this.widgets_below(e);
        return this.remove_from_gridmap(f), e.fadeOut(a.proxy(function () {
            e.remove(), c || g.each(a.proxy(function (b, c) {
                this.move_widget_up(a(c), f.size_y)
            }, this)), this.set_dom_grid_height(), d && d.call(this, b)
        }, this)), this
    }, f.remove_all_widgets = function (b) {
        return this.$widgets.each(a.proxy(function (a, c) {
            this.remove_widget(c, !0, b)
        }, this)), this
    }, f.serialize = function (b) {
        b || (b = this.$widgets);
        var c = [];
        return b.each(a.proxy(function (b, d) {
            c.push(this.options.serialize_params(a(d), a(d).coords().grid))
        }, this)), c
    }, f.serialize_changed = function () {
        return this.serialize(this.$changed)
    }, f.register_widget = function (b) {
        var c = {col: parseInt(b.attr("data-col"), 10), row: parseInt(b.attr("data-row"), 10), size_x: parseInt(b.attr("data-sizex"), 10), size_y: parseInt(b.attr("data-sizey"), 10), max_size_x: parseInt(b.attr("data-max-sizex"), 10) || !1, max_size_y: parseInt(b.attr("data-max-sizey"), 10) || !1, el: b};
        return this.options.avoid_overlapped_widgets && !this.can_move_to({size_x: c.size_x, size_y: c.size_y}, c.col, c.row) && (a.extend(c, this.next_position(c.size_x, c.size_y)), b.attr({"data-col": c.col, "data-row": c.row, "data-sizex": c.size_x, "data-sizey": c.size_y})), b.data("coords", b.coords()), b.data("coords").grid = c, this.add_to_gridmap(c, b), this.options.resize.enabled && this.add_resize_handle(b), this
    }, f.update_widget_position = function (a, b) {
        return this.for_each_cell_occupied(a, function (a, c) {
            return this.gridmap[a] ? (this.gridmap[a][c] = b, void 0) : this
        }), this
    }, f.remove_from_gridmap = function (a) {
        return this.update_widget_position(a, !1)
    }, f.add_to_gridmap = function (b, c) {
        if (this.update_widget_position(b, c || b.el), b.el) {
            var d = this.widgets_below(b.el);
            d.each(a.proxy(function (b, c) {
                this.move_widget_up(a(c))
            }, this))
        }
    }, f.draggable = function () {
        var b = this, c = a.extend(!0, {}, this.options.draggable, {offset_left: this.options.widget_margins[0], container_width: this.container_width, ignore_dragging: ["INPUT", "TEXTAREA", "SELECT", "BUTTON", "." + this.options.resize.handle_class], start: function (c, d) {
            b.$widgets.filter(".player-revert").removeClass("player-revert"), b.$player = a(this), b.$helper = a(d.$helper), b.helper = !b.$helper.is(b.$player), b.on_start_drag.call(b, c, d), b.$el.trigger("gridster:dragstart")
        }, stop: function (a, c) {
            b.on_stop_drag.call(b, a, c), b.$el.trigger("gridster:dragstop")
        }, drag: throttle(function (a, c) {
            b.on_drag.call(b, a, c), b.$el.trigger("gridster:drag")
        }, 60)});
        return this.drag_api = this.$el.drag(c), this
    }, f.resizable = function () {
        return this.resize_api = this.$el.drag({items: "." + this.options.resize.handle_class, offset_left: this.options.widget_margins[0], container_width: this.container_width, move_element: !1, start: a.proxy(this.on_start_resize, this), stop: a.proxy(function (b, c) {
            delay(a.proxy(function () {
                this.on_stop_resize(b, c)
            }, this), 120)
        }, this), drag: throttle(a.proxy(this.on_resize, this), 60)}), this
    }, f.setup_resize = function () {
        this.resize_handle_class = this.options.resize.handle_class;
        var b = this.options.resize.axes, c = '<span class="' + this.resize_handle_class + " " + this.resize_handle_class + '-{type}" />';
        return this.resize_handle_tpl = a.map(b,function (a) {
            return c.replace("{type}", a)
        }).join(""), this
    }, f.on_start_drag = function (b, c) {
        this.$helper.add(this.$player).add(this.$wrapper).addClass("dragging"), this.$player.addClass("player"), this.player_grid_data = this.$player.coords().grid, this.placeholder_grid_data = a.extend({}, this.player_grid_data), this.$el.css("height", this.$el.height() + this.player_grid_data.size_y * this.min_widget_height);
        var d = this.faux_grid, e = this.$player.data("coords").coords;
        this.cells_occupied_by_player = this.get_cells_occupied(this.player_grid_data), this.cells_occupied_by_placeholder = this.get_cells_occupied(this.placeholder_grid_data), this.last_cols = [], this.last_rows = [], this.collision_api = this.$helper.collision(d, this.options.collision), this.$preview_holder = a("<" + this.$player.get(0).tagName + " />", {"class": "preview-holder", "data-row": this.$player.attr("data-row"), "data-col": this.$player.attr("data-col"), css: {width: e.width, height: e.height}}).appendTo(this.$el), this.options.draggable.start && this.options.draggable.start.call(this, b, c)
    }, f.on_drag = function (a, b) {
        if (null === this.$player)return!1;
        var c = {left: b.position.left + this.baseX, top: b.position.top + this.baseY};
        this.colliders_data = this.collision_api.get_closest_colliders(c), this.on_overlapped_column_change(this.on_start_overlapping_column, this.on_stop_overlapping_column), this.on_overlapped_row_change(this.on_start_overlapping_row, this.on_stop_overlapping_row), this.helper && this.$player && this.$player.css({left: b.position.left, top: b.position.top}), this.options.draggable.drag && this.options.draggable.drag.call(this, a, b)
    }, f.on_stop_drag = function (a, b) {
        this.$helper.add(this.$player).add(this.$wrapper).removeClass("dragging"), b.position.left = b.position.left + this.baseX, b.position.top = b.position.top + this.baseY, this.colliders_data = this.collision_api.get_closest_colliders(b.position), this.on_overlapped_column_change(this.on_start_overlapping_column, this.on_stop_overlapping_column), this.on_overlapped_row_change(this.on_start_overlapping_row, this.on_stop_overlapping_row), this.$player.addClass("player-revert").removeClass("player").attr({"data-col": this.placeholder_grid_data.col, "data-row": this.placeholder_grid_data.row}).css({left: "", top: ""}), this.$changed = this.$changed.add(this.$player), this.cells_occupied_by_player = this.get_cells_occupied(this.placeholder_grid_data), this.set_cells_player_occupies(this.placeholder_grid_data.col, this.placeholder_grid_data.row), this.$player.coords().grid.row = this.placeholder_grid_data.row, this.$player.coords().grid.col = this.placeholder_grid_data.col, this.options.draggable.stop && this.options.draggable.stop.call(this, a, b), this.$preview_holder.remove(), this.$player = null, this.$helper = null, this.placeholder_grid_data = {}, this.player_grid_data = {}, this.cells_occupied_by_placeholder = {}, this.cells_occupied_by_player = {}, this.set_dom_grid_height()
    }, f.on_start_resize = function (b, c) {
        this.$resized_widget = c.$player.closest(".gs-w"), this.resize_coords = this.$resized_widget.coords(), this.resize_wgd = this.resize_coords.grid, this.resize_initial_width = this.resize_coords.coords.width, this.resize_initial_height = this.resize_coords.coords.height, this.resize_initial_sizex = this.resize_coords.grid.size_x, this.resize_initial_sizey = this.resize_coords.grid.size_y, this.resize_last_sizex = this.resize_initial_sizex, this.resize_last_sizey = this.resize_initial_sizey, this.resize_max_size_x = Math.min(this.resize_wgd.max_size_x || this.options.resize.max_size[0], this.cols - this.resize_wgd.col + 1), this.resize_max_size_y = this.resize_wgd.max_size_y || this.options.resize.max_size[1], this.resize_dir = {right: c.$player.is("." + this.resize_handle_class + "-x"), bottom: c.$player.is("." + this.resize_handle_class + "-y")}, this.$resized_widget.css({"min-width": this.options.widget_base_dimensions[0], "min-height": this.options.widget_base_dimensions[1]});
        var d = this.$resized_widget.get(0).tagName;
        this.$resize_preview_holder = a("<" + d + " />", {"class": "preview-holder resize-preview-holder", "data-row": this.$resized_widget.attr("data-row"), "data-col": this.$resized_widget.attr("data-col"), css: {width: this.resize_initial_width, height: this.resize_initial_height}}).appendTo(this.$el), this.$resized_widget.addClass("resizing"), this.options.resize.start && this.options.resize.start.call(this, b, c, this.$resized_widget)
    }, f.on_stop_resize = function (b, c) {
        this.$resized_widget.removeClass("resizing").css({width: "", height: ""}), delay(a.proxy(function () {
            this.$resize_preview_holder.remove().css({"min-width": "", "min-height": ""})
        }, this), 300), this.options.resize.stop && this.options.resize.stop.call(this, b, c, this.$resized_widget)
    }, f.on_resize = function (a, b) {
        var c = b.pointer.diff_left, d = b.pointer.diff_top, e = this.options.widget_base_dimensions[0], f = this.options.widget_base_dimensions[1], g = 1 / 0, h = 1 / 0, i = Math.ceil(c / (this.options.widget_base_dimensions[0] + 2 * this.options.widget_margins[0]) - .2), j = Math.ceil(d / (this.options.widget_base_dimensions[1] + 2 * this.options.widget_margins[1]) - .2), k = Math.max(1, this.resize_initial_sizex + i), l = Math.max(1, this.resize_initial_sizey + j);
        k = Math.min(k, this.resize_max_size_x), g = this.resize_max_size_x * e + 2 * (k - 1) * this.options.widget_margins[0], l = Math.min(l, this.resize_max_size_y), h = this.resize_max_size_y * f + 2 * (l - 1) * this.options.widget_margins[1], this.resize_dir.right ? l = this.resize_initial_sizey : this.resize_dir.bottom && (k = this.resize_initial_sizex);
        var m = {};
        !this.resize_dir.bottom && (m.width = Math.min(this.resize_initial_width + c, g)), !this.resize_dir.right && (m.height = Math.min(this.resize_initial_height + d, h)), this.$resized_widget.css(m), (k !== this.resize_last_sizex || l !== this.resize_last_sizey) && (this.resize_widget(this.$resized_widget, k, l, !1), this.$resize_preview_holder.css({width: "", height: ""}).attr({"data-row": this.$resized_widget.attr("data-row"), "data-sizex": k, "data-sizey": l})), this.options.resize.resize && this.options.resize.resize.call(this, a, b, this.$resized_widget), this.resize_last_sizex = k, this.resize_last_sizey = l
    }, f.on_overlapped_column_change = function (b, c) {
        if (!this.colliders_data.length)return this;
        var d, e = this.get_targeted_columns(this.colliders_data[0].el.data.col), f = this.last_cols.length, g = e.length;
        for (d = 0; g > d; d++)-1 === a.inArray(e[d], this.last_cols) && (b || a.noop).call(this, e[d]);
        for (d = 0; f > d; d++)-1 === a.inArray(this.last_cols[d], e) && (c || a.noop).call(this, this.last_cols[d]);
        return this.last_cols = e, this
    }, f.on_overlapped_row_change = function (b, c) {
        if (!this.colliders_data.length)return this;
        var d, e = this.get_targeted_rows(this.colliders_data[0].el.data.row), f = this.last_rows.length, g = e.length;
        for (d = 0; g > d; d++)-1 === a.inArray(e[d], this.last_rows) && (b || a.noop).call(this, e[d]);
        for (d = 0; f > d; d++)-1 === a.inArray(this.last_rows[d], e) && (c || a.noop).call(this, this.last_rows[d]);
        this.last_rows = e
    }, f.set_player = function (a, b, c) {
        var d = this;
        c || this.empty_cells_player_occupies();
        var e = c ? {col: a} : d.colliders_data[0].el.data, f = e.col, g = b || e.row;
        this.player_grid_data = {col: f, row: g, size_y: this.player_grid_data.size_y, size_x: this.player_grid_data.size_x}, this.cells_occupied_by_player = this.get_cells_occupied(this.player_grid_data);
        var h = this.get_widgets_overlapped(this.player_grid_data), i = this.widgets_constraints(h);
        if (this.manage_movements(i.can_go_up, f, g), this.manage_movements(i.can_not_go_up, f, g), !h.length) {
            var j = this.can_go_player_up(this.player_grid_data);
            j !== !1 && (g = j), this.set_placeholder(f, g)
        }
        return{col: f, row: g}
    }, f.widgets_constraints = function (b) {
        var c, d = a([]), e = [], f = [];
        return b.each(a.proxy(function (b, c) {
            var g = a(c), h = g.coords().grid;
            this.can_go_widget_up(h) ? (d = d.add(g), e.push(h)) : f.push(h)
        }, this)), c = b.not(d), {can_go_up: this.sort_by_row_asc(e), can_not_go_up: this.sort_by_row_desc(f)}
    }, f.sort_by_row_asc = function (b) {
        return b = b.sort(function (b, c) {
            return b.row || (b = a(b).coords().grid, c = a(c).coords().grid), b.row > c.row ? 1 : -1
        })
    }, f.sort_by_row_and_col_asc = function (a) {
        return a = a.sort(function (a, b) {
            return a.row > b.row || a.row === b.row && a.col > b.col ? 1 : -1
        })
    }, f.sort_by_col_asc = function (a) {
        return a = a.sort(function (a, b) {
            return a.col > b.col ? 1 : -1
        })
    }, f.sort_by_row_desc = function (a) {
        return a = a.sort(function (a, b) {
            return a.row + a.size_y < b.row + b.size_y ? 1 : -1
        })
    }, f.manage_movements = function (b, c, d) {
        return a.each(b, a.proxy(function (a, b) {
            var e = b, f = e.el, g = this.can_go_widget_up(e);
            if (g)this.move_widget_to(f, g), this.set_placeholder(c, g + e.size_y); else {
                var h = this.can_go_player_up(this.player_grid_data);
                if (!h) {
                    var i = d + this.player_grid_data.size_y - e.row;
                    this.move_widget_down(f, i), this.set_placeholder(c, d)
                }
            }
        }, this)), this
    }, f.is_player = function (a, b) {
        if (b && !this.gridmap[a])return!1;
        var c = b ? this.gridmap[a][b] : a;
        return c && (c.is(this.$player) || c.is(this.$helper))
    }, f.is_player_in = function (b, c) {
        var d = this.cells_occupied_by_player || {};
        return a.inArray(b, d.cols) >= 0 && a.inArray(c, d.rows) >= 0
    }, f.is_placeholder_in = function (b, c) {
        var d = this.cells_occupied_by_placeholder || {};
        return this.is_placeholder_in_col(b) && a.inArray(c, d.rows) >= 0
    }, f.is_placeholder_in_col = function (b) {
        var c = this.cells_occupied_by_placeholder || [];
        return a.inArray(b, c.cols) >= 0
    }, f.is_empty = function (a, b) {
        return"undefined" != typeof this.gridmap[a] ? "undefined" != typeof this.gridmap[a][b] && this.gridmap[a][b] === !1 ? !0 : !1 : !0
    }, f.is_occupied = function (a, b) {
        return this.gridmap[a] ? this.gridmap[a][b] ? !0 : !1 : !1
    }, f.is_widget = function (a, b) {
        var c = this.gridmap[a];
        return c ? (c = c[b], c ? c : !1) : !1
    }, f.is_widget_under_player = function (a, b) {
        return this.is_widget(a, b) ? this.is_player_in(a, b) : !1
    }, f.get_widgets_under_player = function (b) {
        b || (b = this.cells_occupied_by_player || {cols: [], rows: []});
        var c = a([]);
        return a.each(b.cols, a.proxy(function (d, e) {
            a.each(b.rows, a.proxy(function (a, b) {
                this.is_widget(e, b) && (c = c.add(this.gridmap[e][b]))
            }, this))
        }, this)), c
    }, f.set_placeholder = function (b, c) {
        var d = a.extend({}, this.placeholder_grid_data), e = this.widgets_below({col: d.col, row: d.row, size_y: d.size_y, size_x: d.size_x}), f = b + d.size_x - 1;
        f > this.cols && (b -= f - b);
        var g = this.placeholder_grid_data.row < c, h = this.placeholder_grid_data.col !== b;
        this.placeholder_grid_data.col = b, this.placeholder_grid_data.row = c, this.cells_occupied_by_placeholder = this.get_cells_occupied(this.placeholder_grid_data), this.$preview_holder.attr({"data-row": c, "data-col": b}), (g || h) && e.each(a.proxy(function (c, e) {
            this.move_widget_up(a(e), this.placeholder_grid_data.col - b + d.size_y)
        }, this));
        var i = this.get_widgets_under_player(this.cells_occupied_by_placeholder);
        i.length && i.each(a.proxy(function (b, e) {
            var f = a(e);
            this.move_widget_down(f, c + d.size_y - f.data("coords").grid.row)
        }, this))
    }, f.can_go_player_up = function (a) {
        var b = a.row + a.size_y - 1, c = !0, d = [], e = 1e4, f = this.get_widgets_under_player();
        return this.for_each_column_occupied(a, function (a) {
            var g = this.gridmap[a], h = b + 1;
            for (d[a] = []; --h > 0 && (this.is_empty(a, h) || this.is_player(a, h) || this.is_widget(a, h) && g[h].is(f));)d[a].push(h), e = e > h ? h : e;
            return 0 === d[a].length ? (c = !1, !0) : (d[a].sort(function (a, b) {
                return a - b
            }), void 0)
        }), c ? this.get_valid_rows(a, d, e) : !1
    }, f.can_go_widget_up = function (a) {
        var b = a.row + a.size_y - 1, c = !0, d = [], e = 1e4;
        return this.for_each_column_occupied(a, function (f) {
            var g = this.gridmap[f];
            d[f] = [];
            for (var h = b + 1; --h > 0 && (!this.is_widget(f, h) || this.is_player_in(f, h) || g[h].is(a.el));)this.is_player(f, h) || this.is_placeholder_in(f, h) || this.is_player_in(f, h) || d[f].push(h), e > h && (e = h);
            return 0 === d[f].length ? (c = !1, !0) : (d[f].sort(function (a, b) {
                return a - b
            }), void 0)
        }), c ? this.get_valid_rows(a, d, e) : !1
    }, f.get_valid_rows = function (b, c, d) {
        for (var e = b.row, f = b.row + b.size_y - 1, g = b.size_y, h = d - 1, i = []; ++h <= f;) {
            var j = !0;
            if (a.each(c, function (b, c) {
                a.isArray(c) && -1 === a.inArray(h, c) && (j = !1)
            }), j === !0 && (i.push(h), i.length === g))break
        }
        var k = !1;
        return 1 === g ? i[0] !== e && (k = i[0] || !1) : i[0] !== e && (k = this.get_consecutive_numbers_index(i, g)), k
    }, f.get_consecutive_numbers_index = function (a, b) {
        for (var c = a.length, d = [], e = !0, f = -1, g = 0; c > g; g++) {
            if (e || a[g] === f + 1) {
                if (d.push(g), d.length === b)break;
                e = !1
            } else d = [], e = !0;
            f = a[g]
        }
        return d.length >= b ? a[d[0]] : !1
    }, f.get_widgets_overlapped = function () {
        var b = a([]), c = [], d = this.cells_occupied_by_player.rows.slice(0);
        return d.reverse(), a.each(this.cells_occupied_by_player.cols, a.proxy(function (e, f) {
            a.each(d, a.proxy(function (d, e) {
                if (!this.gridmap[f])return!0;
                var g = this.gridmap[f][e];
                this.is_occupied(f, e) && !this.is_player(g) && -1 === a.inArray(g, c) && (b = b.add(g), c.push(g))
            }, this))
        }, this)), b
    }, f.on_start_overlapping_column = function (a) {
        this.set_player(a, !1)
    }, f.on_start_overlapping_row = function (a) {
        this.set_player(!1, a)
    }, f.on_stop_overlapping_column = function (a) {
        this.set_player(a, !1);
        var b = this;
        this.for_each_widget_below(a, this.cells_occupied_by_player.rows[0], function () {
            b.move_widget_up(this, b.player_grid_data.size_y)
        })
    }, f.on_stop_overlapping_row = function (a) {
        this.set_player(!1, a);
        for (var b = this, c = this.cells_occupied_by_player.cols, d = 0, e = c.length; e > d; d++)this.for_each_widget_below(c[d], a, function () {
            b.move_widget_up(this, b.player_grid_data.size_y)
        })
    }, f.move_widget_to = function (b, c) {
        var d = this, e = b.coords().grid;
        c - e.row;
        var f = this.widgets_below(b), g = this.can_move_to(e, e.col, c, b);
        return g === !1 ? !1 : (this.remove_from_gridmap(e), e.row = c, this.add_to_gridmap(e), b.attr("data-row", c), this.$changed = this.$changed.add(b), f.each(function (b, c) {
            var e = a(c), f = e.coords().grid, g = d.can_go_widget_up(f);
            g && g !== f.row && d.move_widget_to(e, g)
        }), this)
    }, f.move_widget_up = function (b, c) {
        var d = b.coords().grid, e = d.row, f = [];
        return c || (c = 1), this.can_go_up(b) ? (this.for_each_column_occupied(d, function (d) {
            if (-1 === a.inArray(b, f)) {
                var g = b.coords().grid, h = e - c;
                if (h = this.can_go_up_to_row(g, d, h), !h)return!0;
                var i = this.widgets_below(b);
                this.remove_from_gridmap(g), g.row = h, this.add_to_gridmap(g), b.attr("data-row", g.row), this.$changed = this.$changed.add(b), f.push(b), i.each(a.proxy(function (b, d) {
                    this.move_widget_up(a(d), c)
                }, this))
            }
        }), void 0) : !1
    }, f.move_widget_down = function (b, c) {
        var d, e, f, g;
        if (0 >= c)return!1;
        if (d = b.coords().grid, e = d.row, f = [], g = c, !b)return!1;
        if (-1 === a.inArray(b, f)) {
            var h = b.coords().grid, i = e + c, j = this.widgets_below(b);
            this.remove_from_gridmap(h), j.each(a.proxy(function (b, c) {
                var d = a(c), e = d.coords().grid, f = this.displacement_diff(e, h, g);
                f > 0 && this.move_widget_down(d, f)
            }, this)), h.row = i, this.update_widget_position(h, b), b.attr("data-row", h.row), this.$changed = this.$changed.add(b), f.push(b)
        }
    }, f.can_go_up_to_row = function (b, c, d) {
        var e, f = this.gridmap, g = !0, h = [], i = b.row;
        if (this.for_each_column_occupied(b, function (a) {
            for (f[a], h[a] = [], e = i; e-- && this.is_empty(a, e) && !this.is_placeholder_in(a, e);)h[a].push(e);
            return h[a].length ? void 0 : (g = !1, !0)
        }), !g)return!1;
        for (e = d, e = 1; i > e; e++) {
            for (var j = !0, k = 0, l = h.length; l > k; k++)h[k] && -1 === a.inArray(e, h[k]) && (j = !1);
            if (j === !0) {
                g = e;
                break
            }
        }
        return g
    }, f.displacement_diff = function (a, b, c) {
        var d = a.row, e = [], f = b.row + b.size_y;
        this.for_each_column_occupied(a, function (a) {
            for (var b = 0, c = f; d > c; c++)this.is_empty(a, c) && (b += 1);
            e.push(b)
        });
        var g = Math.max.apply(Math, e);
        return c -= g, c > 0 ? c : 0
    }, f.widgets_below = function (b) {
        var c = a.isPlainObject(b) ? b : b.coords().grid, d = this;
        this.gridmap;
        var e = c.row + c.size_y - 1, f = a([]);
        return this.for_each_column_occupied(c, function (b) {
            d.for_each_widget_below(b, e, function () {
                return d.is_player(this) || -1 !== a.inArray(this, f) ? void 0 : (f = f.add(this), !0)
            })
        }), this.sort_by_row_asc(f)
    }, f.set_cells_player_occupies = function (a, b) {
        return this.remove_from_gridmap(this.placeholder_grid_data), this.placeholder_grid_data.col = a, this.placeholder_grid_data.row = b, this.add_to_gridmap(this.placeholder_grid_data, this.$player), this
    }, f.empty_cells_player_occupies = function () {
        return this.remove_from_gridmap(this.placeholder_grid_data), this
    }, f.can_go_up = function (a) {
        var b = a.coords().grid, c = b.row, d = c - 1;
        this.gridmap;
        var e = !0;
        return 1 === c ? !1 : (this.for_each_column_occupied(b, function (a) {
            return this.is_widget(a, d), this.is_occupied(a, d) || this.is_player(a, d) || this.is_placeholder_in(a, d) || this.is_player_in(a, d) ? (e = !1, !0) : void 0
        }), e)
    }, f.can_move_to = function (a, b, c, d) {
        this.gridmap;
        var e = a.el, f = {size_y: a.size_y, size_x: a.size_x, col: b, row: c}, g = !0, h = b + a.size_x - 1;
        return h > this.cols ? !1 : d && d < c + a.size_y - 1 ? !1 : (this.for_each_cell_occupied(f, function (b, c) {
            var d = this.is_widget(b, c);
            !d || a.el && !d.is(e) || (g = !1)
        }), g)
    }, f.get_targeted_columns = function (a) {
        for (var b = (a || this.player_grid_data.col) + (this.player_grid_data.size_x - 1), c = [], d = a; b >= d; d++)c.push(d);
        return c
    }, f.get_targeted_rows = function (a) {
        for (var b = (a || this.player_grid_data.row) + (this.player_grid_data.size_y - 1), c = [], d = a; b >= d; d++)c.push(d);
        return c
    }, f.get_cells_occupied = function (a) {
        var b, c = {cols: [], rows: []};
        for (arguments[1]instanceof jQuery && (a = arguments[1].coords().grid), b = 0; b < a.size_x; b++) {
            var d = a.col + b;
            c.cols.push(d)
        }
        for (b = 0; b < a.size_y; b++) {
            var e = a.row + b;
            c.rows.push(e)
        }
        return c
    }, f.for_each_cell_occupied = function (a, b) {
        return this.for_each_column_occupied(a, function (c) {
            this.for_each_row_occupied(a, function (a) {
                b.call(this, c, a)
            })
        }), this
    }, f.for_each_column_occupied = function (a, b) {
        for (var c = 0; c < a.size_x; c++) {
            var d = a.col + c;
            b.call(this, d, a)
        }
    }, f.for_each_row_occupied = function (a, b) {
        for (var c = 0; c < a.size_y; c++) {
            var d = a.row + c;
            b.call(this, d, a)
        }
    }, f._traversing_widgets = function (b, c, d, e, f) {
        var g = this.gridmap;
        if (g[d]) {
            var h, i, j = b + "/" + c;
            if (arguments[2]instanceof jQuery) {
                var k = arguments[2].coords().grid;
                d = k.col, e = k.row, f = arguments[3]
            }
            var l = [], m = e, n = {"for_each/above": function () {
                for (; m-- && !(m > 0 && this.is_widget(d, m) && -1 === a.inArray(g[d][m], l) && (h = f.call(g[d][m], d, m), l.push(g[d][m]), h)););
            }, "for_each/below": function () {
                for (m = e + 1, i = g[d].length; i > m && (!this.is_widget(d, m) || -1 !== a.inArray(g[d][m], l) || (h = f.call(g[d][m], d, m), l.push(g[d][m]), !h)); m++);
            }};
            n[j] && n[j].call(this)
        }
    }, f.for_each_widget_above = function (a, b, c) {
        return this._traversing_widgets("for_each", "above", a, b, c), this
    }, f.for_each_widget_below = function (a, b, c) {
        return this._traversing_widgets("for_each", "below", a, b, c), this
    }, f.get_highest_occupied_cell = function () {
        for (var a, b = this.gridmap, c = [], d = [], e = b.length - 1; e >= 1; e--)for (a = b[e].length - 1; a >= 1; a--)if (this.is_widget(e, a)) {
            c.push(a), d[a] = e;
            break
        }
        var f = Math.max.apply(Math, c);
        return this.highest_occupied_cell = {col: d[f], row: f}, this.highest_occupied_cell
    }, f.get_widgets_from = function (b, c) {
        this.gridmap;
        var d = a();
        return b && (d = d.add(this.$widgets.filter(function () {
            var c = a(this).attr("data-col");
            return c === b || c > b
        }))), c && (d = d.add(this.$widgets.filter(function () {
            var b = a(this).attr("data-row");
            return b === c || b > c
        }))), d
    }, f.set_dom_grid_height = function () {
        var a = this.get_highest_occupied_cell().row;
        return this.$el.css("height", a * this.min_widget_height), this
    }, f.generate_stylesheet = function (b) {
        var c, e = "", f = this.options.max_size_x || this.cols;
        b || (b = {}), b.cols || (b.cols = this.cols), b.rows || (b.rows = this.rows), b.namespace || (b.namespace = this.options.namespace), b.widget_base_dimensions || (b.widget_base_dimensions = this.options.widget_base_dimensions), b.widget_margins || (b.widget_margins = this.options.widget_margins), b.min_widget_width = 2 * b.widget_margins[0] + b.widget_base_dimensions[0], b.min_widget_height = 2 * b.widget_margins[1] + b.widget_base_dimensions[1];
        var g = a.param(b);
        if (a.inArray(g, d.generated_stylesheets) >= 0)return!1;
        for (d.generated_stylesheets.push(g), c = b.cols; c >= 0; c--)e += b.namespace + ' [data-col="' + (c + 1) + '"] { left:' + (c * b.widget_base_dimensions[0] + c * b.widget_margins[0] + (c + 1) * b.widget_margins[0]) + "px; }\n";
        for (c = b.rows; c >= 0; c--)e += b.namespace + ' [data-row="' + (c + 1) + '"] { top:' + (c * b.widget_base_dimensions[1] + c * b.widget_margins[1] + (c + 1) * b.widget_margins[1]) + "px; }\n";
        for (var h = 1; h <= b.rows; h++)e += b.namespace + ' [data-sizey="' + h + '"] { height:' + (h * b.widget_base_dimensions[1] + (h - 1) * 2 * b.widget_margins[1]) + "px; }\n";
        for (var i = 1; f >= i; i++)e += b.namespace + ' [data-sizex="' + i + '"] { width:' + (i * b.widget_base_dimensions[0] + (i - 1) * 2 * b.widget_margins[0]) + "px; }\n";
        return this.add_style_tag(e)
    }, f.add_style_tag = function (a) {
        var b = c, d = b.createElement("style");
        return b.getElementsByTagName("head")[0].appendChild(d), d.setAttribute("type", "text/css"), d.styleSheet ? d.styleSheet.cssText = a : d.appendChild(c.createTextNode(a)), this.$style_tags = this.$style_tags.add(d), this
    }, f.remove_style_tags = function () {
        this.$style_tags.remove()
    }, f.generate_faux_grid = function (a, b) {
        this.faux_grid = [], this.gridmap = [];
        var c, d;
        for (c = b; c > 0; c--)for (this.gridmap[c] = [], d = a; d > 0; d--)this.add_faux_cell(d, c);
        return this
    }, f.add_faux_cell = function (b, c) {
        var d = a({left: this.baseX + (c - 1) * this.min_widget_width, top: this.baseY + (b - 1) * this.min_widget_height, width: this.min_widget_width, height: this.min_widget_height, col: c, row: b, original_col: c, original_row: b}).coords();
        return a.isArray(this.gridmap[c]) || (this.gridmap[c] = []), this.gridmap[c][b] = !1, this.faux_grid.push(d), this
    }, f.add_faux_rows = function (a) {
        for (var b = this.rows, c = b + (a || 1), d = c; d > b; d--)for (var e = this.cols; e >= 1; e--)this.add_faux_cell(d, e);
        return this.rows = c, this.options.autogenerate_stylesheet && this.generate_stylesheet(), this
    }, f.add_faux_cols = function (a) {
        for (var b = this.cols, c = b + (a || 1), d = b; c > d; d++)for (var e = this.rows; e >= 1; e--)this.add_faux_cell(e, d);
        return this.cols = c, this.options.autogenerate_stylesheet && this.generate_stylesheet(), this
    }, f.recalculate_faux_grid = function () {
        var c = this.$wrapper.width();
        return this.baseX = (a(b).width() - c) / 2, this.baseY = this.$wrapper.offset().top, a.each(this.faux_grid, a.proxy(function (a, b) {
            this.faux_grid[a] = b.update({left: this.baseX + (b.data.col - 1) * this.min_widget_width, top: this.baseY + (b.data.row - 1) * this.min_widget_height})
        }, this)), this
    }, f.get_widgets_from_DOM = function () {
        return this.$widgets.each(a.proxy(function (b, c) {
            this.register_widget(a(c))
        }, this)), this
    }, f.generate_grid_and_stylesheet = function () {
        var c = this.$wrapper.width();
        this.$wrapper.height();
        var d = this.options.max_cols, e = Math.floor(c / this.min_widget_width) + this.options.extra_cols, f = this.$widgets.map(function () {
            return a(this).attr("data-col")
        }).get();
        f.length || (f = [0]);
        var g = Math.max.apply(Math, f), h = this.options.extra_rows;
        return this.$widgets.each(function (b, c) {
            h += +a(c).attr("data-sizey")
        }), this.cols = Math.max(g, e, this.options.min_cols), d && d >= g && d < this.cols && (this.cols = d), this.rows = Math.max(h, this.options.min_rows), this.baseX = (a(b).width() - c) / 2, this.baseY = this.$wrapper.offset().top, this.container_width = this.cols * this.options.widget_base_dimensions[0] + 2 * (this.cols - 1) * this.options.widget_margins[0], this.options.autogenerate_stylesheet && this.generate_stylesheet(), this.generate_faux_grid(this.rows, this.cols)
    }, f.destroy = function () {
        return a(b).unbind(".gridster"), this.drag_api && this.drag_api.destroy(), this.remove_style_tags(), this.$el.remove(), this
    }, a.fn.gridster = function (b) {
        return this.each(function () {
            a(this).data("gridster") || a(this).data("gridster", new d(this, b))
        })
    }, a.Gridster = f
}(jQuery, window, document);

//init


$(function () {
    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token',
                $('meta[name="csrf-token"]').attr('content'));
        }
    });
    var request = $.ajax({
        url: "/dashboard.json",
        type: "GET",
        dataType: "json"
    });

    request.done(function (response) {
        if (response.desktop_conf[0]) {
            var i = 0;
            _.each(document.getElementsByClassName('widget'), function (widget) {

                if (response.desktop_conf[i]) {
                    widget.setAttribute('data-row', response.desktop_conf[i][0]);
                    widget.setAttribute('data-col', response.desktop_conf[i][1]);
                    widget.setAttribute('data-sizex', response.desktop_conf[i][2]);
                    widget.setAttribute('data-sizey', response.desktop_conf[i][3]);
                }

                i++

            });
        }
    });

    var gridster = $(".gridster ul").gridster(
        {
            widget_margins: [10, 10],
            widget_base_dimensions: [140, 140],
            avoid_overlapped_widgets: true,
            max_size_x: 6,
            max_size_y: 4,
            max_cols: 6,
            resize: {
                enabled: true
            }
        }
    ).data('gridster');

    console.log(gridster);
    var widgets = $('.gridster li');
    gridster.disable(widgets);
    gridster.disable_resize(widgets);





// Add widget
    $('.add-widget-btn').live('click', function () {
        gridster.add_widget('<li class="new">The HTML of the widget...</li>', 1, 1);
    });

// Remove widget
    gridster.$el
        .live('click', '.icon-cancel-circled', function () {
            gridster.remove_widget($(this).parent('li'));
        });


    $('.widget.disable').on('click', function () {
        return false;
    });


// Enter edit-mode

    $('#edit-current-desktop').bind('click',function () {

        $('.edit-nav').show();

        //   $('.main-desktop-title').html(' <div class="row-fuild clearfix edit-nav"><div class="col-md-3 column"><span class="edit-mode clearfix dropdown"><a type="button" class="ajax-link" href="#" id="dropdownMenu1" data-toggle="dropdown">Главный рабочий стол</a><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2"><li><a class="icon-pencil" href="#">Переименовать</a></li><li><a class="icon-trash" href="#">Удалить</a></li><li><a class="icon-block-1" href="#">Отмена</a></li><li class="other-desktop"><span class="title">Другие столы</span><a class="rename" href="#">Диспетчерская</a><span class="widgets-count">12 виджетов</span><a class="rename" href="#">Общение</a><span class="widgets-count">3 виджета</span></li><li class="dropdown-arr"></li><li><a class="icon-plus-1" href="#">Добавить рабочий стол</a></li></ul><i>(режим редактирования)</i></span></div><div class="col-md-3 col-md-offset-3 column"><button class="btn default-primary save" type="button">Сохранить изменения</button></div><div id="exit-edit" class="col-md-3 column"><a type="button" href="#">Выйти из режима редактирования</a></div></div><div class="row clearfix add-widget"><div class="col-md-9 col-md-offset-2 column"><a class="add-widget-btn" href="#"><span class="icon-plus-1"></span>Добавить виджет на рабочий стол</a></div></div>');
        $('.page.full').addClass('editing');
        widgets.append('<span class="icon-resize-full-alt" data-toggle="tooltip" data-placement="left" title="Перемещение виджета по рабочему столу зажав левую кнопку мыши"></span><span class="icon-resize-full" data-toggle="tooltip" data-placement="left" title="Изменение размера виджета зажав левую кнопку мыши на нижней и правой границе виджета"></span><span class="icon-cancel-circled" title="Удалить виджет"></span>');
        gridster.enable(widgets);
        gridster.enable_resize(widgets);


        $('.wrapper .widget a').on('click', function () {
            return false
        });


//save current position widgets

        $('.save').click(function () {

            var data = new Array();

            //var newdata = gridster.serialize(widgets);

            _.each(document.getElementsByClassName('widget'), function (widget) {

                var name = widget.classList[1];
                var Ar = new Array;
                Ar.push(widget.getAttribute('data-row'))
                Ar.push(widget.getAttribute('data-col'))
                Ar.push(widget.getAttribute('data-sizex'))
                Ar.push(widget.getAttribute('data-sizey'))

                data.push(Ar)
            })
//            var data = {widgets: {docs: [1,2,4,5], mops: [1,2,4,5], loks: [1,2,4,5]}}

            data = {
                widgets: data
            }

            var request = $.ajax({
                url: "/save_desktop_configuration",
                type: "POST",
                dataType: "json",
                data: data
            });

            $('#exit-edit a').click();

        });


    })/*.data('gridster')*/;

//cancel
    $('#cancel-edit-current-desktop').bind('click', function () {

    });
// Exit edit-mode
    $('#exit-edit a').on('click',function () {
        //   $('.main-desktop-controls').html('<h3>Главный рабочий стол</h3>');
        $('.widget a').on('click', function () {
            document.location = this.href;
        });

        $('.wrapper').removeClass('editing');
        $('.edit-nav').hide();
        $('.icon-resize-full-alt, .icon-resize-full, .icon-cancel-circled').remove();
        gridster.disable(widgets);
        gridster.disable_resize(widgets);
    }).data('gridster');
});

