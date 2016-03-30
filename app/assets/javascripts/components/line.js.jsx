var Line = React.createClass({
  propTypes: {
    type: React.PropTypes.string.isRequired,
    name: React.PropTypes.string.isRequired,
    outage: React.PropTypes.object
  },

  render: function() {
    var lineClass = "type-" + this.props.type;
    var outageDetail;
    if (this.props.outage) {
      outageDetail = <Outage {...outage} />
    } else {
      outageDetail = <NoOutage />;
    }
    return (
      <div className={lineClass}>
        <span className="icons">
          <i className={[this.props.type, "symbole"].join(" ")}></i>
          <i className={[this.props.type, "ligne" + this.props.name].join(" ")}></i>
          { outageDetail }
        </span>
        <span >
          <UptimeBlock data={[]} />
          <UptimePercentage percentage="42.2" outageCount="15" />
        </span >
      </div>
    )
  }
});
