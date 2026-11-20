import { useCallback, useEffect, useState } from 'react';
import { api, clearApiCache, getCachedApi } from '../api/client';

export default function useFetch(path) {
  const cachedInitial = path ? getCachedApi(path) ?? null : null;
  const [state, setState] = useState({
    data: cachedInitial,
    loading: Boolean(path) && cachedInitial === null,
    error: null,
  });
  const [tick, setTick] = useState(0);

  useEffect(() => {
    if (!path) {
      setState({ data: null, loading: false, error: null });
      return undefined;
    }
    const ctrl = new AbortController();
    const cached = getCachedApi(path) ?? null;
    setState({ data: cached, loading: cached === null, error: null });
    api(path, ctrl.signal)
      .then((data) => setState({ data, loading: false, error: null }))
      .catch((error) => {
        if (error.name === 'AbortError') return;
        setState((prev) => ({
          data: prev.data,
          loading: false,
          error: prev.data ? null : error,
        }));
      });
    return () => ctrl.abort();
  }, [path, tick]);

  const reload = useCallback(() => {
    clearApiCache();
    setTick((t) => t + 1);
  }, []);
  return { ...state, reload };
}
