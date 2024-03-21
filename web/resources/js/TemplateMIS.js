window.Template = {
    version: 9,
    template: "",
    context: '.mis-template',
    mis: {
        1: {
            8: {viewURL: "mis1-9?action=showdata", context: ".mis1-template-8", template: ""},
            9: {viewURL: "mis-form-1?action=showdata", context: ".mis1-template-9", template: ""}
        },
        11: {
            8: {viewURL: "mis1-9?action=showdata", context: ".mis1-template-8", template: ""},
            9: {viewURL: "mis-form-1-test?action=showdata", context: ".mis1-template-9", template: ""}
        },
        111: {
            8: {viewURL: "mis1-9?action=showdata", context: ".mis1-template-8", template: ""},
            9: {viewURL: "mis-form-1-additional?action=showdata", context: ".mis1-template-9", template: ""}
        },
        2: {
            8: {viewURL: "mis2-9?action=showdata", context: ".mis2-template-8", template: ""},
            9: {viewURL: "MIS_2?action=showdata", context: ".mis2-template-9", template: ""}
        },
        22: {
            8: {viewURL: "mis2-9?action=showdata", context: ".mis2-template-8", template: ""},
            9: {viewURL: "MIS_2_DGFP?action=showdata", context: ".mis2-template-9", template: ""}
        },
        4: {
            8: {viewURL: "MIS_4?action=showData", context: ".mis4-template-9", template: ""},
            9: {viewURL: "MIS_4?action=showData", context: ".mis4-template-9", template: ""}
        },
        44: {
            8: {viewURL: "MIS_4_DGFP?action=showData", context: ".mis4-template-9", template: ""},
            9: {viewURL: "MIS_4_DGFP?action=showData", context: ".mis4-template-9", template: ""}
        }

    },
    data: {},
    attr: function (version, key, val) {
        version = version || this.version;
        var args = arguments, len = args.length;
        if (len === 3) {
            this.data[version][key] = val;
            return this;
        } else if (len === 2) {
            return this.data[version][key];
        } else {
            //this.data[version]['version'] = version;
            return this.data[version];
        }
    },
    getData: function (version) {
        return this.attr(version);
    },
    getViewURL: function (version) {
        version = version || this.version;
        return this.attr(version, 'viewURL');
    },
    getTemplate: function (version) {
        version = version || this.version;
        return this.attr(version, 'template');
    },
    setTemplate: function (version) {
        this.version = version;
        this.viewURL = this.getViewURL(version);
        this.template = this.getTemplate(version);
    },
    reportValue: function (v, b) {
        var _v = finiteFilter(v);
        return _v ? e2b(_v) : (b ? e2b(_v) : '');
    },
    getVersion: function (year, month) {
        return $.app.getVersionMIS(year, month);
    },
    pairs: function (context) {
        context = context || '#areaPanel';
        return $.app.pairs($(':input', context));
    },
    init: function (misNo) {
        if (!this.mis[misNo]) {
            throw new Error("MIS DATA  is not defined");
        }
        console.log(misNo);
        this.data = this.mis[misNo];
        this.attr(8, 'template', $(this.attr(8, 'context')).html());
        this.attr(9, 'template', $(this.attr(9, 'context')).html());
        this.reset();
    },
    reset: function (version) {
        version = version || this.version;
        this.setTemplate(version);
        $(this.context).html(this.template);
    }
};