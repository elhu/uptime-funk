var UptimePercentage = React.createClass({
  propTypes: {
    percentage: React.PropTypes.number.isRequired,
    outageCount: React.PropTypes.number.isRequired
  },

  render: function() {
    var classes = ["stats"];
    classes.push(this.props.percentage == 100 ? "normal" : "outage");
    return (
      <div className={classes.join(" ")}>
        <span className="percentage">
          {this.props.percentage}
        </span>
        <div className="outageCount">{this.props.outageCount} incidents</div>
      </div>
    );
  }
});
