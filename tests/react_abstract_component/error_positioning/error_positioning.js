// Errors should always point to the components. This is a regression test to
// make sure we don't ruin reason locations that go through EvalTs.

const React = require('react');

declare function HOC<
  Props: {},
  TComponent: React.ComponentType<Props>,
>(
  Component: TComponent,
): React.ComponentType<
   Omit<React.ElementConfig<TComponent>, 'foo'>
>;
type MockFn<TArguments: $ReadOnlyArray<any>, TReturn> = {
  (...args: TArguments): TReturn,
  mock: {
    calls: Array<TArguments>,
  }
};

declare function fn<TArguments: $ReadOnlyArray<any>, TReturn>(
  implementation?: (...args: TArguments) => TReturn,
): MockFn<TArguments, TReturn>

const Component = fn<[{user: mixed}], _>(({user}) => (
  <div />
));


let RefetchContainer = HOC<any, _>(Component); // Error, mock is not a Component
<RefetchContainer />;

// This test makes sure that create element issues always point to callers of the
// component instead of the defintion
const C = require('./C');
const View = require('./View');

const _a = <C component={View}></ C>;
