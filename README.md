# quiz_app
# Apps Working Flow in Clean Architecture Bloc

UI -> bloc -> domain(usecase) -> domain(repositories) -> data(repositories) -> data(datasources) -> data(models)/ entity


Understanding BLoC Pattern
BLoC = Business Logic Component

Events: User actions/triggers

States: UI states that change based on events

Bloc: Handles business logic and transforms events to states

# When to Create Events, States, and Bloc Functions
Events (When to create):
User interactions (button taps, form submissions)

Lifecycle events (app started, page loaded)

External triggers (notifications, timers)

Data needs (fetch, update, delete)

States (When to create):
Different UI states (loading, success, error, initial)

Data changes that affect UI

Authentication states

Form validation states

Bloc Functions:
For each event, create a handler function

Business logic and API calls go here

State emissions based on logic results

A new Flutter project.
Clean Architecture, Bloc State management and hive cache and get it DI

## Development Working Flow
main (not completed) -> core(error(failure), usecase(usecase)) ->
feature(feature_name) -> domain(entities(look_model)) -> data(model(model_name)) ->
dart run build_runner build (if use HiveObject)

feature(feature_name) -> domain(repositories(repository_name)) -> feature(feature_name) -> domain -> usecase (usecase_name) ->
feature(feature_name)->domain->repositories ->
feature/feature_name/data/data_source(local, remote) ->
feature/feature_name/data/repositories/repository_impl ->
feature/feature_name/presentation/bloc -> bloc_event, bloc_state, bloc_name ->
screen_design -> Dependency Injection -> main

)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# get it for dependency injection
As your app grows, you need a way to access services, models, and business logic from anywhere without tightly coupling your code to widget trees. get_it is a simple, type-safe service locator that gives you O(1) access to your objects from anywhere in your app—no BuildContext required, no code generation, no magic.

Think of it as a smart container that holds your app's important objects. Register them once at startup, then access them from anywhere. Simple, fast, and testable.