export default function SkeletonCard() {
  return (
    <div className="card small" aria-hidden="true">
      <div className="skeleton skeleton-line short" style={{ width: 70, height: 18, marginBottom: 14 }} />
      <div className="skeleton skeleton-line title" />
      <div className="skeleton skeleton-line text" />
      <div className="skeleton skeleton-line text" />
      <div className="skeleton skeleton-line short" />
    </div>
  );
}
