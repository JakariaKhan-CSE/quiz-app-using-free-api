# quiz_app

A new Flutter project.
Clean Architecture, Bloc State management and hive cache and get it DI

## Working Flow
main (not completed) -> core(error(failure), usecase(usecase)) ->
feature(feature_name) -> domain(entities(look_model)) -> data(model(model_name)) ->
dart run build_runner build (if use HiveObject)

feature(feature_name) -> domain(repositories(repository_name)) -> feature(feature_name) -> domain -> usecase (usecase_name) ->
feature(feature_name)->domain->repositories
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