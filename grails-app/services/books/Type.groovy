package books

enum Type {

    CHILD(PARENT),
    PARENT(CHILD)

    private final Type reverse

    Type(Type reverse) {
        this.reverse = reverse
    }

    Type getReverse() {
        return reverse
    }
}
