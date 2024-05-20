/// @title Verify that the solution is unique
rule solutionIsUnique(
    uint8 Sara,
    uint8 Ophelia,
    uint8 Nora,
    uint8 Dawn
) {
    // Each sister was born in one of the four months
    require Sara >= September() && Sara <= December();
    require Ophelia >= September() && Ophelia <= December();
    require Nora >= September() && Nora <= December();
    require Dawn >= September() && Dawn <= December();

    // "None of us have an initial that matches the initial of her birth month."
    require (
        Sara != September() &&
        Ophelia != October() &&
        Nora != November() &&
        Dawn != December()
    );

    // Ophelia is not the girl who was born in September
    require Ophelia != September();

    // Nora is not the girl who was born in September
    require Nora != September();

    // Nora's birth month does not start with a vowel
    require Nora != October();

    // The sisters were born on different months
    require (
        Sara != Ophelia &&
        Sara != Nora &&
        Sara != Dawn &&
        Ophelia != Nora &&
        Ophelia != Dawn &&
        Nora != Dawn
    );

    assert (
        Sara == October() &&
        Ophelia == November() &&
        Nora == December() &&
        Dawn == September()
    );
}