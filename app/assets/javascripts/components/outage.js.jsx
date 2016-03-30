var Outage = React.createClass({
  propTypes: {
    description: React.PropTypes.string.isRequired,
    startedAt: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <div className="details outage">
        <i className="fa fa-exclamation-triangle outage" />
        <span className="beginning">
          { this.props.startedAt }
          <i className="fa long-arrow-right" />
        </span>
        <span className="description">
          { this.props.description }
        </span>
      </div>
    )
  }
});
